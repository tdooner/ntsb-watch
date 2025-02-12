class Investigation < ApplicationRecord
  has_many :daily_sync_differences

  def self.find_or_initialize_from_json(json)
    find_or_initialize_by(ntsb_mkey: json["cm_mkey"])
      .assign_ntsb_json_attributes(json)
  end

  def to_html
    # TODO: This is whack. It should be a partial.
    location = [ contents_raw["cm_city"], contents_raw["cm_state"], contents_raw["cm_country"] ].compact.join(", ")
    date = DateTime.parse(contents_raw["cm_eventDate"]).strftime("%m/%d/%Y")
    first_vehicle = Array(contents_raw["cm_vehicles"]).first
    mishap =
      if first_vehicle
        first_vehicle["cm_events"].first["cicttEventSOEGroup"]
      else
        "Unknown Mishap"
      end

    injuries = Array(first_vehicle["cm_injuries"]).first
    injuries_text =
      if injuries
        "#{injuries["cm_crew_Fatal"]} Fatal, #{injuries["cm_crew_Serious"]} Serious, #{injuries["cm_crew_None"]} None"
      else
        "Unknown Injuries"
      end
    report_url = "https://data.ntsb.gov/carol-repgen/api/Aviation/ReportMain/GenerateNewestReport/#{contents_raw["cm_mkey"]}/pdf"

    base_details = <<~HTML
      <li><strong>Location:</strong> #{location}</li>
      <li><strong>Date:</strong> #{date}</li>
      <li><strong>Details:</strong> #{mishap} / #{injuries_text}</li>
    HTML
    report_details = <<~HTML if most_recent_report_type.present?
      <li>
        <strong>Report URL:</strong> <a href="#{report_url}" target="_blank" rel="noopener noreferer">Download Latest Report</a> (Dated #{contents_raw["cm_recentReportPublishDate"]})
      </li>
    HTML

    <<~HTML.html_safe
      <ul>
        #{base_details}
        #{report_details}
      </ul>
    HTML
  end

  def assign_ntsb_json_attributes(json)
    assign_attributes(
      ntsb_mkey: json["cm_mkey"],
      completion_status: json["cm_completionStatus"],
      event_date: DateTime.parse(json["cm_eventDate"]),
      most_recent_report_type: json["cm_mostRecentReportType"],
      contents_raw: json
    )
    self
  end
end

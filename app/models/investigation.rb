class Investigation < ApplicationRecord
  has_many :daily_sync_differences

  def self.find_or_initialize_from_json(json)
    find_or_initialize_by(ntsb_mkey: json["cm_mkey"])
      .assign_ntsb_json_attributes(json)
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

  def report_url
    "https://data.ntsb.gov/carol-repgen/api/Aviation/ReportMain/GenerateNewestReport/#{ntsb_mkey}/pdf"
  end

  def recent_report_publish_date
    if contents_raw["cm_originalPublishedDate"]
      DateTime.parse(contents_raw["cm_originalPublishedDate"])
    else
      DateTime.parse(contents_raw["cm_recentReportPublishDate"])
    end
  end
end

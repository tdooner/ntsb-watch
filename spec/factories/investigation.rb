FactoryBot.define do
  factory :investigation do
    ntsb_mkey { 12345 }
    completion_status { "In work" }
    event_date { (DateTime.now - 1.day).iso8601 }
    most_recent_report_type { "Prelim" }
    contents_raw { {} }

    transient do
      fixture_name { nil }
    end

    after(:build) do |investigation, evaluator|
      if evaluator.fixture_name
        json = JSON.load_file(Rails.root.join("spec", "fixtures", "investigation", evaluator.fixture_name))
        investigation.assign_ntsb_json_attributes(json)
      else
        investigation.contents_raw.reverse_merge!(
          "cm_mkey" => investigation.ntsb_mkey,
          "cm_completionStatus" => investigation.completion_status,
          "cm_eventDate" => investigation.event_date,
          "cm_mostRecentReportType" => investigation.most_recent_report_type,
        )
      end
    end
  end
end

FactoryBot.define do
  factory :investigation do
    ntsb_mkey { 12345 }
    completion_status { "In work" }
    event_date { (DateTime.now - 1.day).iso8601 }
    most_recent_report_type { "Prelim" }
    contents_raw { {} }

    after(:build) do |investigation, _evaluator|
      investigation.contents_raw.reverse_merge!(
        "cm_mkey" => investigation.ntsb_mkey,
        "cm_completionStatus" => investigation.completion_status,
        "cm_eventDate" => investigation.event_date,
        "cm_mostRecentReportType" => investigation.most_recent_report_type,
      )
    end
  end
end

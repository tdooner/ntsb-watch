class HomeController < ApplicationController
  def home
    @recent_reports = Investigation
      .where("contents_raw->>'cm_mostRecentReportType' IN (?)", [ "Prelim", "Final" ])
      .order(Arel.sql("contents_raw->>'cm_recentReportPublishDate' desc nulls last"))
      .limit(20)

    @investigations = Investigation.order(created_at: :desc).limit(10)
    @diffs = DailySyncDifference.order(created_at: :desc).limit(20)
  end
end

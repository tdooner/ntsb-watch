class HomeController < ApplicationController
  def home
    @recent_prelim_reports = Investigation
      .where("contents_raw->>'cm_mostRecentReportType' = ?", "Prelim")
      .order(Arel.sql("contents_raw->>'cm_recentReportPublishDate' desc nulls last"))
      .limit(10)

    @recent_final_reports = Investigation
      .where("contents_raw->>'cm_mostRecentReportType' = ?", "Final")
      .order(Arel.sql("contents_raw->>'cm_recentReportPublishDate' desc nulls last"))
      .limit(10)

    @investigations = Investigation.order(created_at: :desc).limit(10)
  end
end

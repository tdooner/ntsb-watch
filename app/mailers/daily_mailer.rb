class DailyMailer < ApplicationMailer
  def daily_mail(email, interval: Date.yesterday.all_day)
    @differences = DailySyncDifference.where(created_at: interval).includes(:investigation)

    mail to: email, subject: "NTSB Daily Alert for #{Date.today}"
  end
end

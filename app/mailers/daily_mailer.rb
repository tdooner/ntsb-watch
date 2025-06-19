class DailyMailer < ApplicationMailer
  def daily_mail(email, interval: 24.hours.ago..Time.now)
    @differences = DailySyncDifference.where(created_at: interval).includes(:investigation)

    mail to: email, subject: "NTSB Daily Alert for #{Date.today}"
  end
end

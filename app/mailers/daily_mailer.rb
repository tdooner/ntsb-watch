# typed: true

class DailyMailer < ApplicationMailer
  sig { params(user: User, interval: T::Range[Date]).returns(T.untyped) }
  def daily_mail(user, interval: 24.hours.ago..Time.now)
    differences = DailySyncDifference.where(created_at: interval).includes(:investigation)

    watched_investigations = user.watched_investigations.to_set

    @watched_differences, @unwatched_differences = differences.partition { |d| watched_investigations.include?(d.investigation) }

    mail to: user.email, subject: "#{("🚨 " if @watched_differences.any?)}NTSB Daily Alert for #{Date.today}"
  end
end

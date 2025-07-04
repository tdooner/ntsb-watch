# typed: true

class DailyMailerPreview < ActionMailer::Preview
  def daily_mail
    user = User.first || User.new(email: "test@example.com")
    DailyMailer.daily_mail(user, interval: (Date.today - 10.days)..Date.today)
  end
end

class DailyMailerPreview < ActionMailer::Preview
  def daily_mail
    DailyMailer.daily_mail("test@example.com", interval: (Date.today - 10.days)..Date.today)
  end
end

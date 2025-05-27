namespace :ntsb_alert do
  task daily_sync: :environment do
    DailySync.new(Date.today).download_all

    DailyMailer.daily_mail("tomdooner@gmail.com").deliver_now
  end
end

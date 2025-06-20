namespace :ntsb_alert do
  task daily_sync: :environment do
    DailySync.new(Date.today).download_all

    User.find_each do |user|
      DailyMailer.daily_mail(user).deliver_now
    end
  end
end

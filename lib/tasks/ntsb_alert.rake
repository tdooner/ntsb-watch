namespace :ntsb_alert do
  task daily_sync: :environment do
    DailySync.new(Date.today).download_all
  end
end

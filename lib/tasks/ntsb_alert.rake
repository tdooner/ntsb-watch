namespace :ntsb_alert do
  task download_daily: :environment do
    DailyDownloader.new(Date.today).download_all
  end
end

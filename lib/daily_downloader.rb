class DailyDownloader
  def initialize(date, logger = $stdout)
    @date = date
    @client = CarolApiClient.new
    @logger = logger
  end

  def download_all
    5.times do |i|
      download_year(@date - i.years)
    end
  end

  def download_year(year)
    @logger.puts "Downloading all NTSB investigations from year: #{year.year}"

    start_date, end_date = year.all_year.minmax

    counts = { total: 0, updated: 0, created: 0 }

    @client.investigations(start_date, end_date).each_with_index do |json, i|
      investigation = Investigation.find_or_initialize_from_json(json)
      counts[:total] += 1
      counts[:updated] += 1 if investigation.persisted? && investigation.changed?
      counts[:created] += 1 if investigation.new_record?

      investigation.save
      @logger.puts "  Processed #{counts[:total]} records. (Created: #{counts[:created]}, Updated: #{counts[:updated]})" if counts[:total] % 100 == 0
    end

    @logger.puts "  Finished. (Total: #{counts[:total]}, Created: #{counts[:created]}, Updated: #{counts[:updated]})"
  end
end

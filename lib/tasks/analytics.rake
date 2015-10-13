namespace :analytics do
  desc "Call Google Analytics Api for get data of url"
  task :add_records, [:time] => :environment do |t, args|
    time = args.time
    time_range(time)
    urls = Url.all

    urls.each do |url|
      page_stadistics = AnalyticConnection.new.historical_data_for(source: 'Page', url: url.only_path, start_date: @start_date, end_date: @end_date)
      country_stadistics = AnalyticConnection.new.historical_data_for(source: 'Country', url: url.only_path, start_date: @start_date, end_date: @end_date)
      traffic_stadistics = AnalyticConnection.new.historical_data_for(source: 'Traffic', url: url.only_path, start_date: @start_date, end_date: @end_date)
      device_stadistics = AnalyticConnection.new.historical_data_for(source: 'Device', url: url.only_path, start_date: @start_date, end_date: @end_date)

      page_stadistics.each do |data|
        PageStadistic.create(url: url, date: data.date.to_date, avgtimeonpage: data.avgtimeonpage.to_f, pageviews: data.pageviews.to_i, sessions: data.sessions.to_i)
      end

      country_stadistics.each do |data|
        CountryStadistic.create(url: url, date: data.date.to_date, country_code: data.countryIsoCode, country_name: data.country, pageviews: data.pageviews.to_i)
      end

      traffic_stadistics.each do |data|
        TrafficStadistic.create(url: url, date: data.date.to_date, traffic_type: data.traffictype, pageviews: data.pageviews.to_i)
      end

      device_stadistics.each do |data|
        DeviceStadistic.create(url: url, date: data.date.to_date, device_type: data.deviceCategory, pageviews: data.pageviews.to_i)
      end

    end

    puts 'Task complete...'
  end

  def time_range(time)
    case time
    when 'year'
      @start_date = 1.year.ago
      @end_date = Time.now
    when 'month'
      @start_date = 1.month.ago
      @end_date = Time.now
    when 'week'
      @start_date = 1.week.ago
      @end_date = Time.now
    when 'day'
      @start_date = 1.day.ago
      @end_date = Time.now
    end
  end

end

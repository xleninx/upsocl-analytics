class DfpConnection
  require 'dfp_api_statement'
  require 'dfp_api'
  require 'open-uri'

  API_VERSION = :v201508
  MAX_RETRIES = 10
  RETRY_INTERVAL = 30

  def initialize
    @dfp = DfpApi::Api.new({
      authentication: {
          method: 'OAuth2',
          oauth2_client_id: ENV['DFP_CLIENT_ID'],
          oauth2_client_secret: ENV['DFP_CLIENT_SECRET'],
          application_name: ENV['DFP_APPLICATION_NAME'],
          network_code: 100064084,
          oauth2_token: {
            access_token: ENV['DFP_ACCESS_TOKEN'],
            refresh_token: ENV['DFP_REFRESH_TOKEN'],
            issued_at: ENV['DFP_ISSUE_AT'].to_time,
            expires_in: 3600
          }
      },
      service: { environment: 'PRODUCTION' },
      connection: { enable_gzip: false },
      library: { log_level: 'INFO' }
    })
  end

  def var
    @dfp
  end

  def run_report()
    # Get DfpApi instance and load configuration from ~/dfp_api.yml.
    dfp = @dfp

    # To enable logging of SOAP requests, set the log_level value to 'DEBUG' in
    # the configuration file or provide your own logger:
    # dfp.logger = Logger.new('dfp_xml.log')

    # Get the ReportService.
    report_service = dfp.service(:ReportService, API_VERSION)

    # Specify the order ID to filter by.

    # Specify a report to run for the last 7 days.
    report_end_date = DateTime.now
    report_start_date = report_end_date - 7

    # Create report query.
    report_query = {
      :date_range_type => 'CUSTOM_DATE',
      :start_date => {:year => report_start_date.year,
                      :month => report_start_date.month,
                      :day => report_start_date.day},
      :end_date => {:year => report_end_date.year,
                    :month => report_end_date.month,
                    :day => report_end_date.day},
      :dimensions => ['DATE', 'LINE_ITEM_NAME'],
      :columns => ['AD_SERVER_IMPRESSIONS', 'AD_SERVER_CLICKS', 'AD_SERVER_CTR'],
      # Create statement object to filter for an order.
    }

    # Create report job.
    report_job = {:report_query => report_query}

    # Run report job.
    report_job = report_service.run_report_job(report_job);

    MAX_RETRIES.times do |retry_count|
      # Get the report job status.
      report_job_status = report_service.get_report_job_status(report_job[:id])

      break unless report_job_status == 'IN_PROGRESS'
      puts "Report with ID: %d is still running." % report_job[:id]
      sleep(RETRY_INTERVAL)
    end

    puts "Report job with ID: %d finished with status %s." %
        [report_job[:id],
         report_service.get_report_job_status(report_job[:id])]

     # Change to your preffered export format.
     export_format = 'CSV_DUMP'

     # Get the report URL.
     download_url = report_service.get_report_download_url(
        report_job[:id], export_format);

    file_name = 'test.csv'
    puts "Downloading [%s] to [%s]..." % [download_url, file_name]

    source = open(download_url)
    gz = Zlib::GzipReader.new(source)

    open(file_name, 'wb') do |local_file|
     local_file << gz.read
    end

    CSV.foreach(file_name, converters: :numeric, headers: true) do |row|
      # Additional row processing
       puts row['Dimension.ORDER_NAME']
    end
  end
end

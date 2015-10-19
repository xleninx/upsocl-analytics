class Url < ActiveRecord::Base
  belongs_to :campaign
  has_and_belongs_to_many :countries
  has_many :page_stadistics
  has_many :dfp_stadistics
  has_many :country_stadistics
  has_many :device_stadistics
  has_many :traffic_stadistics

  attr_accessor :params

  validates :data, presence: true, url: { no_local: true, message: 'el formato no es correto' }
  validates :line_id, presence: true

  before_save :set_title, :make_screenshot

  def social_count
    SocialShares.selected data, %w(facebook google twitter)
  end

  def analytics_data
    Analytic.new.data_for(source: 'Page', url: only_path).first
  end

  def set_title
    if !title.nil? and data_changed?
      agent = Mechanize.new
      agent.get(data)
      self.title = agent.page.title
    end
  end

  def make_screenshot
    if (created_at == updated_at) or data_changed?
      f = Screencap::Fetcher.new(self.data)
      path = Rails.root.join('public', 'screenshot', "#{self.id}.png")
      File.delete( path ) if File.exist?( path )
      screenshot = f.fetch( :output => path )
      Magick::Image.read(screenshot).first.crop(0, 110, 1080, 395).write( path )
    end
  end

  def only_path
    URI.parse(data).path
  end

  def stadistics
    objects = ['page_stadistics','dfp_stadistics','device_stadistics','traffic_stadistics']
    result = {}
    objects.each do |obj|
      result[obj] = self.send(obj).where( date: @params[:start_date]..@params[:end_date] ).totals
    end
    result['country_stadistics'] = country_stadistics.where( date: @params[:start_date]..@params[:end_date] ).totals(associated_countries)
    result
  end

  def totals_stadistics
    if countries.any?
      country_stadistics.where( date: @params[:start_date]..@params[:end_date] ).totals_filtered_by(associated_countries)[0]
    else
      page_stadistics.where( date: @params[:start_date]..@params[:end_date] ).totals_in_range
    end

  end

  def associated_countries
    countries.map(&:code)
  end

end

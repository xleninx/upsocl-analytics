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

  before_save :set_title
  after_save :make_screenshot
  before_destroy { |record| clean_screenshot(record.id) }

  def social_count
    SocialShares.selected data, %w(facebook google twitter)
  end

  def set_title
    if data_changed?
      self.title = Pismo[data].titles.last.clean_title
    end
  end

  def clean_title
    split(' | ').first
  end

  def make_screenshot
    url =  Cloudinary::Utils.cloudinary_url(data,
    :type => "url2png",
    :crop => "fill", :width => 1080, :height => 320, :gravity => :north,
    :sign_url => true)
    path = Rails.root.join('public', 'screenshot', "#{self.id}.png")
    open(path, 'wb') do |file|
      file << open(url).read
    end
  end
  handle_asynchronously :make_screenshot

  def clean_screenshot(id)
    path = Rails.root.join('public', 'screenshot', "#{id}.png")
    File.delete( path ) if File.exist?( path )
  end

  def only_path
    URI.parse(data).path
  end

  def stadistics
    objects = ['dfp_stadistics','device_stadistics','traffic_stadistics']
    result = {}
    objects.each do |obj|
      result[obj] = self.send(obj).where( date: @params[:start_date]..@params[:end_date] ).totals
    end
    result['country_stadistics'] = country_stadistics.where( date: @params[:start_date]..@params[:end_date] ).totals(associated_countries)
    result['page_stadistics'] = country_stadistics.where( date: @params[:start_date]..@params[:end_date] ).totals_by_date(associated_countries)
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

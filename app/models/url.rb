class Url < ActiveRecord::Base
  belongs_to :campaign
  validates :data, presence: true, url: { no_local: true, message: 'el formato no es correto' }

  before_save :set_title

  def social_count
    SocialShares.selected data, %w(facebook google twitter)
  end

  def analytics_data
    Analytic.new.data_for(source: 'Page', url: only_path).first
  end

  def set_title
    agent = Mechanize.new
    agent.get(data)
    self.title = agent.page.title
  end

  def only_path
    URI.parse(data).path
  end
end

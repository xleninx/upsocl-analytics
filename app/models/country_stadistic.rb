class CountryStadistic < ActiveRecord::Base
  belongs_to :url
  validates :date, uniqueness: { scope: [ :url, :country_code ] }

  scope :totals, -> { group(:country_name, :country_code).sum(:pageviews).map {|c| { name: c[0][0], code: c[0][1], pageviews: to_percent(c[1]) } } }

  def self.to_percent(val)
     ((val * 100).to_f / self.sum(:pageviews).to_f).round(2).to_s + '%'
  end
end

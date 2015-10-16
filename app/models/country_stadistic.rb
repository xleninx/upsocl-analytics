class CountryStadistic < ActiveRecord::Base
  belongs_to :url
  validates :date, uniqueness: { scope: [ :url, :country_code ] }

  scope :totals, -> (countries) { (countries.any? ? where('country_code in (?)', countries) : self ).group(:country_name, :country_code).sum(:pageviews).map {|c| { name: c[0][0], code: c[0][1], pageviews: c[1], pageviews_percent: to_percent(c[1]) } } }

  scope :totals_filtered_by, -> (countries) { where('country_code in (?)', countries).select(['SUM(pageviews) as pageviews', 'SUM(users) as users', 'trunc((AVG(avgtimeonpage) /60)::numeric,2) as avgtimeonpage' ]) }

  def self.to_percent(val)
     ((val * 100).to_f / self.sum(:pageviews).to_f).round(2).to_s + '%'
  end

end

class DeviceStadistic < ActiveRecord::Base
  belongs_to :url
  validates :date, uniqueness: { scope: [ :url, :device_type ] }

  scope :totals, -> { group(:device_type).sum(:pageviews).map {|c| { device: c[0].titleize, pageviews: c[1]} } }
end

class DfpStadistic < ActiveRecord::Base
  belongs_to :url
  validates :date, uniqueness: { scope: [ :url, :line_id ] }

  scope :totals, -> { { impressions: sum(:impressions), clicks: sum(:clicks), ctr: sum(:ctr) } }

end

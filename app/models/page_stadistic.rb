class PageStadistic < ActiveRecord::Base
  belongs_to :url
  validates :date, uniqueness: { scope: :url }
end

class Url < ActiveRecord::Base
  belongs_to :campaign
  validates :data, presence: true, url: { no_local: true, message: 'el formato no es correto' }
end

class Campaign < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :urls

  accepts_nested_attributes_for :urls, allow_destroy: :true

  validates :name, presence: true

  def join_users
    users.map(&:name).join(', ')
  end

end

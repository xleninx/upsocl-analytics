class Campaign < ActiveRecord::Base
  has_and_belongs_to_many :users

  def join_users
    users.map(&:name).join(', ')
  end

end

class FacebookAccount < ActiveRecord::Base
  has_many :facebook_posts
end

class FacebookPost < ActiveRecord::Base
  belongs_to :url
  belongs_to :facebook_account
end

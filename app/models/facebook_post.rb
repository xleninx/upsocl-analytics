class FacebookPost < ActiveRecord::Base
  belongs_to :url
  belongs_to :facebook_account

  def account_id
    facebook_account.facebook_id
  end
end

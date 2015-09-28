class CampaignsController < ApplicationController
  def index
    @campaigns = current_user.campaigns
  end
end

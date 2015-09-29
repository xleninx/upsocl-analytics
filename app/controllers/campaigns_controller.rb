class CampaignsController < ApplicationController

  def index
    @campaigns = current_user.campaigns.decorate
    respond_to do |format|
      format.html {}
      format.json { render :json => @campaigns.as_json }
    end
  end

end

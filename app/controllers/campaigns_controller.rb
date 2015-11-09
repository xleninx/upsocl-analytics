class CampaignsController < ApplicationController

  def index
    @campaigns = checked_campaings.decorate
    respond_to do |format|
      format.html {}
      format.json { render :json => @campaigns.as_json(methods: :num_urls, include: [:urls, users: { only: [:name] } ] ) }
    end
  end

  def show
    @campaign = current_user.campaigns.find(params[:id]).decorate
    respond_to do |format|
      format.html {}
      format.json { render :json => @campaign.as_json }
    end
  end

  private

  def checked_campaings
    if current_user.admin?
      Campaign.all.order(:name)
    else
      current_user.campaigns
    end

  end

end

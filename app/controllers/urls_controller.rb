class UrlsController < ApplicationController

  def show
    @url = Url.find(params[:id])
    respond_to do |format|
      format.html {}
      format.json { render :json => @url.as_json( methods: [ :campaign, :social_count, :analytics_data ]) }
    end
  end

end

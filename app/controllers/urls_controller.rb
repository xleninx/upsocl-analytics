class UrlsController < ApplicationController

  def show
    @url = Url.find(params[:id])
    @url.params = { :start_date => params[:startDate].to_time, :end_date => params[:endDate].to_time }
    respond_to do |format|
      format.html {}
      format.json { render :json => @url.as_json( methods: [ :campaign, :social_count, :stadistics, :totals_stadistics ]) }
    end
  end

end

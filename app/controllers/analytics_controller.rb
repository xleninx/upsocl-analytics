class AnalyticsController < ApplicationController

  before_action :find_url

  def show
    data = Analytic.new.page_data_for( url: @url.only_path )
    respond_to do |format|
      format.json { render :json => data.as_json }
    end
  end

  def graphs
    analytics = Analytic.new
    data = analytics.group_data_for( sources:['Country', 'Device', 'Traffic'], url: @url.only_path )
    data['Historical'] = analytics.historical_data_for( @url.only_path )
    respond_to do |format|
      format.json { render :json => data }
    end
  end

private

  def find_url
    @url = Url.find(params[:id])
  end
end

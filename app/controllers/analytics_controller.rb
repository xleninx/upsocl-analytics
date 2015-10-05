class AnalyticsController < ApplicationController

  before_action :find_url

  def show
    data = Analytic.new.page_data_for(url: @url.only_path)
    respond_to do |format|
      format.json { render :json => data.as_json }
    end
  end

  def country_data
    data = Analytic.new.country_data_for(url: @url.only_path)
    respond_to do |format|
      format.json { render :json => data.as_json }
    end
  end

private

  def find_url
    @url = Url.find(params[:id])
  end
end

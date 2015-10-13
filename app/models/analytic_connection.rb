class AnalyticConnection
  def initialize
    @user = Legato::User.new GoogleOauth2Installed.access_token
    @profile = @user.profiles.first
  end

  def data_for(source:'', url:'')
    Object.const_get('Analytic::' + source).path(url, @profile).each { |d| p d }
  end

  def historical_data_for( url )
    Analytic::Historical.results( @profile, start_date: 7.days.ago, end_date: DateTime.now ).path( url ).each { |d| p d }
  end

  def group_data_for(sources:[], url:'')
    data = {}
    sources.each do |s|
      data[s] = Object.const_get( 'Analytic::' + s).path( url, @profile ).each { |d| p d }
    end
    data
  end
end

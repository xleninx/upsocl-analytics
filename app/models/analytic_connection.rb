class AnalyticConnection
  def initialize
    @user = Legato::User.new GoogleOauth2Installed.access_token
    @profile = @user.profiles.last
  end

  def data_for(source:'', url:'')
    Object.const_get('Analytic::' + source).path(url, @profile).each { |d| p d }
  end

  def historical_data_for( source:'', url:'', start_date: 1.week.ago , end_date: Time.now )
    Object.const_get('Analytic::' + source).results( @profile, start_date: start_date, end_date: end_date ).path( url ).each { |d| p d }
  end

  def group_data_for(sources:[], url:'')
    data = {}
    sources.each do |s|
      data[s] = Object.const_get( 'Analytic::' + s).path( url, @profile ).each { |d| p d }
    end
    data
  end
end

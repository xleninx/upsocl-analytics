class Analytic
  def initialize
    @user = Legato::User.new GoogleOauth2Installed.access_token
    @profile = @user.profiles.first
  end

  def page_data_for(url:'')
    Page.path(url, @profile).each {|d| p d}
  end

  def country_data_for(url:'')
    Country.path(url, @profile).each {|d| p d}
  end

  def test
    Page.results(@profile, start_date: 2.day.ago, end_date: 1.day.ago)
  end
end

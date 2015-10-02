class Analytic
  def initialize
    @user = Legato::User.new GoogleOauth2Installed.access_token
    @profile = @user.profiles.first
  end

  def data_for(url:'')
    Page.path(url, @profile)
  end

  def test
    Page.results(@profile, start_date: 2.day.ago, end_date: 1.day.ago)
  end
end

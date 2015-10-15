class Analytic::Country
  extend Legato::Model

  metrics :pageviews, :visitors, :sessions, :users, :avgtimeonpage
  dimensions :country, :page_path, :countryIsoCode, :date

  filter :path, &lambda {|path| matches(:page_path, path)}
end

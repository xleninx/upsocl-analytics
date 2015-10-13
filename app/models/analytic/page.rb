class Analytic::Page
  extend Legato::Model

  metrics :pageviews, :visitors, :sessions, :avgtimeonpage, :users
  dimensions :page_path, :date

  filter :path, &lambda {|path| matches(:page_path, path)}
end

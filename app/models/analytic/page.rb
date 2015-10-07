class Analytic::Page
  extend Legato::Model

  metrics :pageviews, :visitors, :sessions, :avgtimeonpage, :percent_new_visits
  dimensions :page_path

  filter :path, &lambda {|path| matches(:page_path, path)}
end

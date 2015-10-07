class Analytic::Device
  extend Legato::Model

  metrics :pageviews, :visitors, :sessions, :timeonpage, :percent_new_visits
  dimensions :page_path, :deviceCategory

  filter :path, &lambda {|path| matches(:page_path, path)}
end

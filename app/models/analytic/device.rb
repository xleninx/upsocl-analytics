class Analytic::Device
  extend Legato::Model

  metrics :pageviews, :visitors, :sessions
  dimensions :page_path, :deviceCategory, :date

  filter :path, &lambda {|path| matches(:page_path, path)}
end

class Analytic::Historical
  extend Legato::Model

  metrics :pageviews, :visitors, :sessions, :newusers, :avgtimeonpage
  dimensions :page_path, :date

  filter :path, &lambda {|path| matches(:page_path, path)}
end

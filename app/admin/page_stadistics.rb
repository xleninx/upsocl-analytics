ActiveAdmin.register PageStadistic do
  permit_params :pageviews, :avgtimeonpage, :url_id, :date, :users, :sessions

  index do
    selectable_column
    column(:campaña) do |u|
      u.url.campaign.name.titleize
    end
    column(:url) do |u|
      truncate(u.url.title, length: 50)
    end
    column :date
    column :pageviews
    column :avgtimeonpage
    actions
  end

  filter :url
  filter :url_id
  filter :date

  form do |f|
    f.inputs "Estadisticas de pagina" do
      f.input :url, :as => :select, :input_html => { :class => "chosen-input"}
      f.input :date
      f.input :avgtimeonpage
      f.input :pageviews
      f.input :users
      f.input :sessions
    end
    f.actions
  end
end

ActiveAdmin.register CountryStadistic do
  permit_params :pageviews, :avgtimeonpage
  config.clear_action_items!
  
  index do
    selectable_column
    column(:campaña) do |u|
      u.url.campaign.name.titleize
    end
    column(:url) do |u|
      truncate(u.url.title, length: 50)
    end
    column :date
    column :country_code
    column :pageviews
    column :avgtimeonpage
    actions
  end

  filter :url
  filter :url_id
  filter :date
  filter :country_code

  form do |f|
    f.inputs "Estadistica por pais" do
      f.input :pageviews
      f.input :avgtimeonpage
    end
    f.actions
  end
end

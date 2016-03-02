ActiveAdmin.register DfpStadistic do
  index do
    selectable_column
    column(:campaña) do |u|
      u.url.campaign.name.titleize
    end
    column(:url) do |u|
      truncate(u.url.title, length: 50)
    end
    column :date
    column :impressions
    column :clicks
    actions
  end

  filter :url
  filter :date

  form do |f|
    f.inputs "Estadistica de dfp" do
      f.input :impressions
      f.input :clicks
    end
    f.actions
  end
end

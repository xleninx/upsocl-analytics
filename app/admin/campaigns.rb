ActiveAdmin.register Campaign do
  permit_params :name, :url, user_ids: []

  index do
    selectable_column
    id_column
    column :name
    column :url
    column(:users) do |c|
      c.join_users
    end
    actions
  end

  filter :name

  form do |f|
    f.inputs "Campaña" do
      f.input :name
      f.input :url
      f.input :users, :as => :select, :input_html => {:multiple => true}
    end
    f.actions
  end

end

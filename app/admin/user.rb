ActiveAdmin.register User do
  permit_params :email, :name, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :email
    column :name
    column :current_sign_in_at
    column :created_at
    actions
  end

  filter :email
  filter :name
  filter :current_sign_in_at
  filter :created_at

  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :name
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end

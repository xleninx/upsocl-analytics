ActiveAdmin.register User do
  permit_params :email, :name, :active,:password, :password_confirmation, campaign_ids: []

  show do
    panel 'Detalles de Usuario' do
      attributes_table_for user do
        row :id
        row :name
        row :active do
          t("#{user.active}_value", scope: 'activerecord.attributes.user/active')
        end
        row :campaigns do
          user.join_campaigns
        end
      end
    end
  end

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
      f.input :campaigns, :as => :select, :input_html => {:multiple => true}
      f.input :active
      f.input :password if f.object.new_record?
      f.input :password_confirmation if f.object.new_record?
    end
    f.actions
  end

end

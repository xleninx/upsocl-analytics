class AddFieldsUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :active, :boolean, default: :true
  end
end

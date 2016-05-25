class AddProfileIdUrl < ActiveRecord::Migration
  def change
    add_column :urls, :profile_id, :string, default: "111669814"
  end
end

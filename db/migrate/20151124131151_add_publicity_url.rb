class AddPublicityUrl< ActiveRecord::Migration
  def change
    add_column :urls, :publicity, :boolean, default: true
  end
end

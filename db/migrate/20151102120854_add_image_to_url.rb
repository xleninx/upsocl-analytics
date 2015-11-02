class AddImageToUrl < ActiveRecord::Migration
  def change
    add_column :urls, :screenshot, :string
  end
end

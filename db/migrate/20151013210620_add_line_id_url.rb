class AddLineIdUrl < ActiveRecord::Migration
  def change
    add_column :urls, :line_id, :integer 
  end
end

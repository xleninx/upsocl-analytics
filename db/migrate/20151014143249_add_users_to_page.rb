class AddUsersToPage < ActiveRecord::Migration
  def change
    add_column :page_stadistics, :users, :integer
  end
end

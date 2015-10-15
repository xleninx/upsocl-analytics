class AddUserAvg < ActiveRecord::Migration
  def change
    add_column :country_stadistics, :users, :integer
    add_column :country_stadistics, :avgtimeonpage, :float
  end
end

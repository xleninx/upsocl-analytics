class CreateCountryStadistics < ActiveRecord::Migration
  def change
    create_table :country_stadistics do |t|
      t.belongs_to :url
      t.string :country_code
      t.integer :pageviews
      t.timestamps null: false
    end
  end
end

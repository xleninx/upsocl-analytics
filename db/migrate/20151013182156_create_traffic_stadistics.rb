class CreateTrafficStadistics < ActiveRecord::Migration
  def change
    create_table :traffic_stadistics do |t|
      t.belongs_to :url, index: true
      t.date :date
      t.string :traffic_type
      t.integer :pageviews
      t.timestamps null: false
    end
  end
end

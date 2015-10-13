class CreateDeviceStadistics < ActiveRecord::Migration
  def change
    create_table :device_stadistics do |t|
      t.belongs_to :url
      t.string :device_type
      t.integer :pageviews
      t.timestamps null: false
    end
  end
end

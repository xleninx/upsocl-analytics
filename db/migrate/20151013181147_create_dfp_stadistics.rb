class CreateDfpStadistics < ActiveRecord::Migration
  def change
    create_table :dfp_stadistics do |t|
      t.belongs_to :url
      t.date :date
      t.string :line_name
      t.integer :line_id
      t.integer :impressions
      t.integer :clicks
      t.float :ctr
      t.timestamps null: false
    end
  end
end

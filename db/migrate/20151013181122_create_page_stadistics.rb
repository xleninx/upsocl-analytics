class CreatePageStadistics < ActiveRecord::Migration
  def change
    create_table :page_stadistics do |t|
      t.belongs_to :url
      t.date :date
      t.float :avgtimeonpage
      t.integer :pageviews
      t.integer :sessions
      t.timestamps null: false
    end
  end
end

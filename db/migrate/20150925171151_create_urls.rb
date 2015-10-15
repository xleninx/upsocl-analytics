class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :data
      t.belongs_to :campaign, index: true
      t.timestamps null: false
    end
  end
end

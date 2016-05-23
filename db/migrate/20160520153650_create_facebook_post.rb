class CreateFacebookPost < ActiveRecord::Migration
  def change
    create_table :facebook_posts do |t|
      t.string :post_id
      t.belongs_to :url, index: true
      t.belongs_to :facebook_account, index: true
    end
  end
end

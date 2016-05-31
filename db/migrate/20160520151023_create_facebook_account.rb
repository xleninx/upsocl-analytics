class CreateFacebookAccount < ActiveRecord::Migration
  def change
    create_table :facebook_accounts do |t|
      t.string :name
      t.string :facebook_id
    end
  end
end

class UrlsCountries < ActiveRecord::Migration
  def change
    create_table :countries_urls, id: false do |t|
      t.belongs_to :url, index: true
      t.belongs_to :country, index: true
    end
  end
end

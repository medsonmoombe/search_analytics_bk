class CreatePopularSearches < ActiveRecord::Migration[8.0]
  def change
    create_table :popular_searches do |t|
      t.string :query
      t.integer :unique_ips
      t.datetime :last_updated

      t.timestamps
    end
  end
end

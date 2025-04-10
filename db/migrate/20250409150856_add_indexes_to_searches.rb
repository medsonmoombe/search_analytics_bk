class AddIndexesToSearches < ActiveRecord::Migration[7.1]
  def change
    add_index :searches, [:query, :ip_address]
    add_index :searches, :created_at
  end
end

class AddMissingIndexesToSearches < ActiveRecord::Migration[8.0]
  def change
    # Single column indexes (you already have created_at)
    add_index :searches, :query
    add_index :searches, :ip_address
    
    # Composite indexes (you already have query+ip_address)
    add_index :searches, [:query, :created_at]
    add_index :searches, [:ip_address, :created_at]
    
    # For popular_searches table (optional but recommended)
    add_index :popular_searches, :query, unique: true
    add_index :popular_searches, :last_updated
  end
end
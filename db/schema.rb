ActiveRecord::Schema[8.0].define(version: 2025_04_09_192924) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "popular_searches", force: :cascade do |t|
    t.string "query"
    t.integer "unique_ips"
    t.datetime "last_updated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["last_updated"], name: "index_popular_searches_on_last_updated"
    t.index ["query"], name: "index_popular_searches_on_query", unique: true
  end

  create_table "searches", force: :cascade do |t|
    t.string "query"
    t.string "ip_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_searches_on_created_at"
    t.index ["ip_address", "created_at"], name: "index_searches_on_ip_address_and_created_at"
    t.index ["ip_address"], name: "index_searches_on_ip_address"
    t.index ["query", "created_at"], name: "index_searches_on_query_and_created_at"
    t.index ["query", "ip_address"], name: "index_searches_on_query_and_ip_address"
    t.index ["query"], name: "index_searches_on_query"
  end
end

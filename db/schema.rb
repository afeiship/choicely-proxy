require "sqlite3"
require "active_record"
require_relative "../src/app"

ActiveRecord::Schema.define do
  create_table :proxies, force: :cascade do |t|
    t.string :ip
    t.string :port
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end
end

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_02_10_013250) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "daily_sync_differences", force: :cascade do |t|
    t.bigint "investigation_id", null: false
    t.date "date"
    t.jsonb "differences"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["investigation_id"], name: "index_daily_sync_differences_on_investigation_id"
  end

  create_table "investigations", force: :cascade do |t|
    t.integer "ntsb_mkey", null: false
    t.string "completion_status"
    t.datetime "event_date", precision: nil
    t.string "most_recent_report_type"
    t.jsonb "contents_raw"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ntsb_mkey"], name: "index_investigations_on_ntsb_mkey", unique: true
  end

  add_foreign_key "daily_sync_differences", "investigations"
end

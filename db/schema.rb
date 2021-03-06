# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161126024845) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "guests", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "rsvp"
    t.boolean  "plus_one"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "wedding_id"
    t.index ["wedding_id"], name: "index_guests_on_wedding_id", using: :btree
  end

  create_table "notes", force: :cascade do |t|
    t.text     "body"
    t.integer  "service_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.index ["service_id"], name: "index_notes_on_service_id", using: :btree
    t.index ["user_id"], name: "index_notes_on_user_id", using: :btree
  end

  create_table "services", force: :cascade do |t|
    t.string   "vendor"
    t.float    "price"
    t.float    "budget"
    t.boolean  "chosen",     default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "wedding_id"
    t.index ["wedding_id"], name: "index_services_on_wedding_id", using: :btree
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "service_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_id"], name: "index_taggings_on_service_id", using: :btree
    t.index ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  create_table "weddings", force: :cascade do |t|
    t.integer  "budget"
    t.date     "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "bride_id"
    t.integer  "groom_id"
    t.integer  "owner_id"
    t.string   "name"
    t.index ["bride_id"], name: "index_weddings_on_bride_id", using: :btree
    t.index ["groom_id"], name: "index_weddings_on_groom_id", using: :btree
    t.index ["owner_id"], name: "index_weddings_on_owner_id", using: :btree
  end

  add_foreign_key "guests", "weddings"
  add_foreign_key "notes", "services"
  add_foreign_key "notes", "users"
  add_foreign_key "services", "weddings"
  add_foreign_key "taggings", "services"
  add_foreign_key "taggings", "tags"
  add_foreign_key "weddings", "users", column: "bride_id"
  add_foreign_key "weddings", "users", column: "groom_id"
  add_foreign_key "weddings", "users", column: "owner_id"
end

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

ActiveRecord::Schema.define(version: 20161028085345) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.boolean  "delta",      default: true, null: false
  end

  create_table "category_types", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.boolean  "delta",      default: true, null: false
  end

  create_table "category_values", force: :cascade do |t|
    t.string   "title"
    t.integer  "category_type_id"
    t.boolean  "public",           default: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.boolean  "delta",            default: true,  null: false
    t.index ["category_type_id"], name: "index_category_values_on_category_type_id", using: :btree
  end

  create_table "component_category_types", force: :cascade do |t|
    t.string    "title"
    t.integer   "component_type_id"
    t.datetime  "created_at",                        null: false
    t.datetime  "updated_at",                        null: false
    t.boolean   "delta",             default: true,  null: false
    t.boolean   "has_sizerange",     default: false
    t.int4range "sizerange"
    t.integer   "number"
    t.boolean   "public",            default: true
    t.index ["component_type_id"], name: "index_component_category_types_on_component_type_id", using: :btree
  end

  create_table "component_category_values", force: :cascade do |t|
    t.string   "title"
    t.integer  "component_category_type_id"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.boolean  "delta",                      default: true, null: false
    t.index ["component_category_type_id"], name: "index_component_category_values_on_component_category_type_id", using: :btree
  end

  create_table "component_subtypes", force: :cascade do |t|
    t.string   "title"
    t.integer  "component_type_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.boolean  "delta",             default: true, null: false
    t.index ["component_type_id"], name: "index_component_subtypes_on_component_type_id", using: :btree
  end

  create_table "component_subtypes_components", id: false, force: :cascade do |t|
    t.integer "component_id",                        null: false
    t.integer "component_subtype_id",                null: false
    t.boolean "delta",                default: true, null: false
    t.index ["component_id"], name: "index_component_subtypes_components_on_component_id", using: :btree
    t.index ["component_subtype_id"], name: "index_component_subtypes_components_on_component_subtype_id", using: :btree
  end

  create_table "component_types", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "delta",      default: true,  null: false
    t.integer  "number"
    t.string   "atitle"
    t.text     "acontent"
    t.boolean  "aactive",    default: false
  end

  create_table "component_types_components", id: false, force: :cascade do |t|
    t.integer "component_id",                     null: false
    t.integer "component_type_id",                null: false
    t.boolean "delta",             default: true, null: false
    t.index ["component_id"], name: "index_component_types_components_on_component_id", using: :btree
    t.index ["component_type_id"], name: "index_component_types_components_on_component_type_id", using: :btree
  end

  create_table "components", force: :cascade do |t|
    t.string    "title"
    t.json      "categories"
    t.text      "description"
    t.datetime  "created_at",                 null: false
    t.datetime  "updated_at",                 null: false
    t.boolean   "delta",       default: true, null: false
    t.int4range "sizerange"
    t.integer   "main_image",  default: 0
  end

  create_table "configurables", force: :cascade do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "index_configurables_on_name", using: :btree
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  end

  create_table "images", force: :cascade do |t|
    t.string   "file"
    t.string   "imageable_type"
    t.integer  "imageable_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "news", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.boolean  "sent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "opinions", force: :cascade do |t|
    t.text     "optext"
    t.integer  "user_id"
    t.boolean  "active"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.boolean  "delta",      default: true, null: false
    t.index ["user_id"], name: "index_opinions_on_user_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.string   "name"
    t.string   "city"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.boolean  "delta",      default: true, null: false
  end

  create_table "orders_users", id: false, force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "user_id",  null: false
    t.index ["order_id"], name: "index_orders_users_on_order_id", using: :btree
    t.index ["user_id"], name: "index_orders_users_on_user_id", using: :btree
  end

  create_table "shoes", force: :cascade do |t|
    t.string   "title"
    t.integer  "user_id"
    t.json     "categories"
    t.string   "description"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "delta",       default: true, null: false
    t.index ["user_id"], name: "index_shoes_on_user_id", using: :btree
  end

  create_table "user_news", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.boolean  "delta",      default: true, null: false
    t.index ["user_id"], name: "index_user_news_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                     default: "",    null: false
    t.string   "encrypted_password",        default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",             default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "provider"
    t.string   "uid"
    t.boolean  "admin",                     default: false
    t.boolean  "blocked",                   default: false
    t.boolean  "subscribe_news_shoes",      default: false
    t.boolean  "subscribe_news_components", default: false
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "organization"
    t.string   "city"
    t.string   "address"
    t.boolean  "producer",                  default: false
    t.string   "url_name"
    t.string   "info"
    t.string   "contact"
    t.string   "delivery_info"
    t.string   "description"
    t.string   "phone_organization"
    t.boolean  "delta",                     default: true,  null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "user_news", "users"
end

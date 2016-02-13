# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160212123506) do

  create_table "assets", force: :cascade do |t|
    t.string   "type"
    t.string   "img_file_name"
    t.string   "img_content_type"
    t.integer  "img_file_size"
    t.datetime "img_updated_at"
    t.integer  "product_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "assets", ["product_id"], name: "index_assets_on_product_id"

  create_table "brand_models", force: :cascade do |t|
    t.string   "name"
    t.integer  "factory_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "brand_models", ["factory_id"], name: "index_brand_models_on_factory_id"

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string   "name"
    t.string   "status_position"
    t.string   "telephone"
    t.string   "email"
    t.integer  "company_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "clients", ["company_id"], name: "index_clients_on_company_id"

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "deliveries", force: :cascade do |t|
    t.string   "direction"
    t.integer  "cost"
    t.integer  "execution_document"
    t.integer  "check_factory"
    t.integer  "bank_service"
    t.float    "bank_percent"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "discounts", force: :cascade do |t|
    t.integer  "percent"
    t.integer  "factory_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "discounts", ["factory_id"], name: "index_discounts_on_factory_id"

  create_table "factories", force: :cascade do |t|
    t.string   "brand"
    t.string   "web"
    t.text     "autorification"
    t.string   "style"
    t.string   "line_product"
    t.string   "catalog"
    t.integer  "additional_discount"
    t.string   "delivery_terms"
    t.text     "note"
    t.float    "light_factor"
    t.integer  "minimum_order"
    t.integer  "delivery_time"
    t.string   "group_brend"
    t.integer  "user_id"
    t.integer  "light_factory_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "factories", ["light_factory_id"], name: "index_factories_on_light_factory_id"
  add_index "factories", ["user_id"], name: "index_factories_on_user_id"

  create_table "products", force: :cascade do |t|
    t.string   "article"
    t.float    "price"
    t.float    "weight"
    t.float    "width"
    t.float    "height"
    t.float    "depth"
    t.float    "unit_v"
    t.integer  "type_furniture_id"
    t.integer  "brand_model_id"
    t.string   "factory_brand"
    t.string   "type_furniture_name"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "text_size"
    t.float    "real_width"
    t.float    "real_height"
    t.float    "real_depth"
  end

  add_index "products", ["brand_model_id"], name: "index_products_on_brand_model_id"
  add_index "products", ["type_furniture_id"], name: "index_products_on_type_furniture_id"

  create_table "projects", force: :cascade do |t|
    t.string   "object_name"
    t.string   "type_furniture"
    t.date     "deadline"
    t.float    "planned_budget"
    t.date     "date_delivery_client"
    t.float    "amount_contract"
    t.float    "client_prepayment"
    t.float    "client_surcharge"
    t.text     "status_transaction"
    t.text     "delivery_status"
    t.boolean  "print_sum"
    t.integer  "user_id"
    t.integer  "city_id"
    t.integer  "client_id"
    t.integer  "style_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "projects", ["city_id"], name: "index_projects_on_city_id"
  add_index "projects", ["client_id"], name: "index_projects_on_client_id"
  add_index "projects", ["style_id"], name: "index_projects_on_style_id"
  add_index "projects", ["user_id"], name: "index_projects_on_user_id"

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "specifications", force: :cascade do |t|
    t.string   "name"
    t.boolean  "light"
    t.boolean  "print_sum"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "specifications", ["project_id"], name: "index_specifications_on_project_id"

  create_table "statuses", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "project_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "statuses", ["project_id"], name: "index_statuses_on_project_id"

  create_table "styles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "table_specifications", force: :cascade do |t|
    t.text     "finishing_for_client"
    t.float    "unit_price_factory"
    t.integer  "increment_discount"
    t.integer  "percent_v"
    t.text     "size"
    t.integer  "number_of"
    t.integer  "interest_percent"
    t.integer  "arhitec_percent"
    t.integer  "group"
    t.float    "additional_delivery"
    t.float    "additional_packaging"
    t.boolean  "selected"
    t.boolean  "required"
    t.integer  "product_id"
    t.integer  "specification_id"
    t.integer  "discount_id"
    t.integer  "delivery_id"
    t.integer  "photo_id"
    t.integer  "size_image_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "table_specifications", ["delivery_id"], name: "index_table_specifications_on_delivery_id"
  add_index "table_specifications", ["discount_id"], name: "index_table_specifications_on_discount_id"
  add_index "table_specifications", ["photo_id"], name: "index_table_specifications_on_photo_id"
  add_index "table_specifications", ["product_id"], name: "index_table_specifications_on_product_id"
  add_index "table_specifications", ["size_image_id"], name: "index_table_specifications_on_size_image_id"
  add_index "table_specifications", ["specification_id"], name: "index_table_specifications_on_specification_id"

  create_table "tables", force: :cascade do |t|
    t.string   "finishing"
    t.text     "finishing_for_client"
    t.float    "unit_price_factory"
    t.integer  "increment_discount"
    t.text     "size"
    t.integer  "percent_v"
    t.integer  "number_of"
    t.integer  "interest_percent"
    t.integer  "arhitec_percent"
    t.integer  "group"
    t.float    "additional_delivery"
    t.float    "additional_packaging"
    t.string   "type"
    t.boolean  "required"
    t.integer  "product_id"
    t.integer  "specification_id"
    t.integer  "discount_id"
    t.integer  "delivery_id"
    t.integer  "photo_id"
    t.integer  "size_image_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "order"
  end

  add_index "tables", ["delivery_id"], name: "index_tables_on_delivery_id"
  add_index "tables", ["discount_id"], name: "index_tables_on_discount_id"
  add_index "tables", ["photo_id"], name: "index_tables_on_photo_id"
  add_index "tables", ["product_id"], name: "index_tables_on_product_id"
  add_index "tables", ["size_image_id"], name: "index_tables_on_size_image_id"
  add_index "tables", ["specification_id"], name: "index_tables_on_specification_id"

  create_table "type_furnitures", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.boolean  "admin"
    t.string   "name"
    t.string   "telephone"
    t.string   "rate"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"

end

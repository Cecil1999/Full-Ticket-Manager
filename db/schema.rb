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

ActiveRecord::Schema[8.1].define(version: 2025_11_16_023911) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "posts", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.boolean "show", default: true
    t.bigint "ticket_id"
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_posts_on_ticket_id"
  end

  create_table "roles", force: :cascade do |t|
    t.boolean "enabled", default: true
    t.string "name"
    t.index ["name"], name: "index_roles_on_name", unique: true
  end

  create_table "roles_users", id: false, force: :cascade do |t|
    t.bigint "role_id"
    t.bigint "user_id"
    t.index ["role_id"], name: "index_roles_users_on_role_id"
    t.index ["user_id"], name: "index_roles_users_on_user_id"
  end

  create_table "ticket_types", force: :cascade do |t|
    t.boolean "enabled", default: true, null: false
    t.string "name"
  end

  create_table "tickets", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.bigint "ticket_type_id"
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["ticket_type_id"], name: "index_tickets_on_ticket_type_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.boolean "enabled", default: true
    t.string "password_digest", null: false
    t.datetime "updated_at", null: false
    t.string "username", null: false
  end

  add_foreign_key "posts", "tickets"
  add_foreign_key "roles_users", "roles"
  add_foreign_key "roles_users", "users"
  add_foreign_key "tickets", "ticket_types"
end

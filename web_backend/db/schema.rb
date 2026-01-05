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

ActiveRecord::Schema[8.1].define(version: 2026_01_03_163949) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "acls", force: :cascade do |t|
    t.string "action", null: false
    t.string "controller", null: false
    t.datetime "created_at", null: false
    t.boolean "enabled", default: true
    t.datetime "updated_at", null: false
  end

  create_table "acls_roles", id: false, force: :cascade do |t|
    t.bigint "acl_id"
    t.bigint "role_id"
    t.index ["acl_id"], name: "index_acls_roles_on_acl_id"
    t.index ["role_id"], name: "index_acls_roles_on_role_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.text "body", null: false
    t.datetime "created_at", default: -> { "now()" }, null: false
    t.boolean "seen", default: false, null: false
    t.string "title", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.boolean "show", default: true
    t.bigint "ticket_id"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["ticket_id"], name: "index_posts_on_ticket_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
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

  create_table "teams", force: :cascade do |t|
    t.boolean "enabled", default: true
    t.string "name", null: false
    t.index ["name"], name: "index_teams_on_name", unique: true
  end

  create_table "ticket_templates", force: :cascade do |t|
    t.text "template", null: false
    t.bigint "ticket_type_id", null: false
    t.index ["ticket_type_id"], name: "index_ticket_templates_on_ticket_type_id"
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
    t.bigint "user_id", null: false
    t.index ["ticket_type_id"], name: "index_tickets_on_ticket_type_id"
    t.index ["user_id"], name: "index_tickets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.boolean "enabled", default: true
    t.string "password_digest", null: false
    t.string "refresh_token"
    t.bigint "team_id"
    t.datetime "updated_at", null: false
    t.string "username", null: false
    t.index ["refresh_token"], name: "index_users_on_refresh_token", unique: true
    t.index ["team_id"], name: "index_users_on_team_id"
  end

  add_foreign_key "acls_roles", "acls"
  add_foreign_key "acls_roles", "roles"
  add_foreign_key "notifications", "users"
  add_foreign_key "posts", "tickets"
  add_foreign_key "posts", "users"
  add_foreign_key "roles_users", "roles"
  add_foreign_key "roles_users", "users"
  add_foreign_key "ticket_templates", "ticket_types"
  add_foreign_key "tickets", "ticket_types"
  add_foreign_key "tickets", "users"
  add_foreign_key "users", "teams"
end

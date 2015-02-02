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

ActiveRecord::Schema.define(version: 20150202091156) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "courses", force: :cascade do |t|
    t.string   "slug",                       null: false
    t.boolean  "published",  default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "courses", ["published"], name: "index_courses_on_published", using: :btree
  add_index "courses", ["slug"], name: "index_courses_on_slug", unique: true, using: :btree

  create_table "steps", force: :cascade do |t|
    t.text   "en_answers",  null: false
    t.text   "ru_answers",  null: false
    t.string "ru_question"
    t.string "ru_help"
    t.string "en_question"
    t.string "en_help"
  end

  create_table "steps_units", force: :cascade do |t|
    t.integer "unit_id"
    t.integer "step_id"
    t.integer "position"
    t.boolean "from_en",  default: true
    t.boolean "to_en",    default: true
    t.boolean "from_ru",  default: true
    t.boolean "to_ru",    default: true
  end

  add_index "steps_units", ["position"], name: "index_steps_units_on_position", using: :btree
  add_index "steps_units", ["step_id", "unit_id"], name: "index_steps_units_on_step_id_and_unit_id", unique: true, using: :btree
  add_index "steps_units", ["step_id"], name: "index_steps_units_on_step_id", using: :btree

  create_table "training_snapshots", force: :cascade do |t|
    t.integer  "training_id"
    t.text     "snapshot",    null: false
    t.datetime "date",        null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "training_snapshots", ["date"], name: "index_training_snapshots_on_date", using: :btree
  add_index "training_snapshots", ["training_id", "date"], name: "index_training_snapshots_on_training_id_and_date", using: :btree

  create_table "trainings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "unit_id"
    t.integer  "language_id",                      null: false
    t.integer  "native_language_id",               null: false
    t.integer  "steps_passed",         default: 0
    t.integer  "words_helped",         default: 0
    t.integer  "steps_helped",         default: 0
    t.integer  "right_answers",        default: 0
    t.integer  "wrong_answers",        default: 0
    t.text     "box_0"
    t.text     "box_1"
    t.text     "box_2"
    t.text     "box_3"
    t.text     "box_4"
    t.integer  "revised_steps_number", default: 0
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "current_step_id"
  end

  add_index "trainings", ["unit_id", "user_id", "language_id", "native_language_id"], name: "training_uniqueness", unique: true, using: :btree
  add_index "trainings", ["unit_id"], name: "index_trainings_on_unit_id", using: :btree
  add_index "trainings", ["user_id"], name: "index_trainings_on_user_id", using: :btree

  create_table "units", force: :cascade do |t|
    t.integer  "course_id"
    t.string   "slug",                               null: false
    t.boolean  "published",          default: false
    t.boolean  "random_steps_order", default: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "units", ["course_id"], name: "index_units_on_course_id", using: :btree
  add_index "units", ["published"], name: "index_units_on_published", using: :btree
  add_index "units", ["slug"], name: "index_units_on_slug", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "token",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "users", ["token"], name: "index_users_on_token", unique: true, using: :btree

  add_foreign_key "steps_units", "steps"
  add_foreign_key "steps_units", "units"
  add_foreign_key "training_snapshots", "trainings"
  add_foreign_key "trainings", "units"
  add_foreign_key "trainings", "users"
  add_foreign_key "units", "courses"
end

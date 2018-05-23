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

ActiveRecord::Schema.define(version: 20180522191646) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "classrooms", force: :cascade do |t|
    t.integer "grade"
    t.string "name"
    t.integer "teacher_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "homework", force: :cascade do |t|
    t.bigint "user_id"
    t.string "title"
    t.string "link"
    t.date "due_date"
    t.string "category"
    t.string "status", default: "Pending"
    t.integer "teacher_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "classroom_id"
    t.index ["classroom_id"], name: "index_homework_on_classroom_id"
    t.index ["user_id"], name: "index_homework_on_user_id"
  end

  create_table "students", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "classroom_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["classroom_id"], name: "index_students_on_classroom_id"
    t.index ["user_id"], name: "index_students_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "email"
    t.string "auth_token"
    t.boolean "teacher", default: false
    t.boolean "student", default: false
    t.integer "grade"
  end

  add_foreign_key "homework", "classrooms"
  add_foreign_key "homework", "users"
  add_foreign_key "students", "classrooms"
  add_foreign_key "students", "users"
end

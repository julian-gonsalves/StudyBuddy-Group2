# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_11_213408) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendees", force: :cascade do |t|
    t.string "event_name"
    t.string "user_name"
    t.bigint "user_id", null: false
    t.bigint "study_group_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["study_group_id"], name: "index_attendees_on_study_group_id"
    t.index ["user_id"], name: "index_attendees_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "course_code"
    t.string "course_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "enrolments", force: :cascade do |t|
    t.string "user_name"
    t.string "course_name"
    t.bigint "user_id", null: false
    t.bigint "course_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_enrolments_on_course_id"
    t.index ["user_id"], name: "index_enrolments_on_user_id"
  end

  create_table "notes", force: :cascade do |t|
    t.string "course_code"
    t.string "title"
    t.string "tag"
    t.string "user_name"
    t.string "timeline"
    t.string "location"
    t.bigint "course_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_notes_on_course_id"
  end

  create_table "study_groups", force: :cascade do |t|
    t.string "event_name"
    t.string "user_name"
    t.string "location"
    t.string "time"
    t.string "description"
    t.string "course_code"
    t.bigint "course_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_study_groups_on_course_id"
  end

  create_table "tutoring_sessions", force: :cascade do |t|
    t.string "tutor_name"
    t.string "student_name"
    t.string "course_code"
    t.bigint "user_id", null: false
    t.bigint "tutor_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tutor_id"], name: "index_tutoring_sessions_on_tutor_id"
    t.index ["user_id"], name: "index_tutoring_sessions_on_user_id"
  end

  create_table "tutors", force: :cascade do |t|
    t.string "user_name"
    t.string "course_code"
    t.text "description"
    t.float "rate"
    t.bigint "user_id", null: false
    t.bigint "course_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_tutors_on_course_id"
    t.index ["user_id"], name: "index_tutors_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "password"
    t.text "description"
    t.string "first_name"
    t.string "last_name"
    t.integer "phone_num"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "attendees", "study_groups"
  add_foreign_key "attendees", "users"
  add_foreign_key "enrolments", "courses"
  add_foreign_key "enrolments", "users"
  add_foreign_key "notes", "courses"
  add_foreign_key "study_groups", "courses"
  add_foreign_key "tutoring_sessions", "tutors"
  add_foreign_key "tutoring_sessions", "users"
  add_foreign_key "tutors", "courses"
  add_foreign_key "tutors", "users"
end
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

ActiveRecord::Schema.define(version: 2021_04_16_200440) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "question_id"
    t.bigint "preference_form_id"
    t.string "answer_type"
    t.text "short_answer"
    t.boolean "true_false"
    t.integer "numeric"
    t.string "multiple_choice"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["preference_form_id"], name: "index_answers_on_preference_form_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "choices", force: :cascade do |t|
    t.text "content"
    t.bigint "question_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_id"], name: "index_choices_on_question_id"
  end

  create_table "matches", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "matched_id"
    t.bigint "preference_form_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["matched_id"], name: "index_matches_on_matched_id"
    t.index ["preference_form_id"], name: "index_matches_on_preference_form_id"
    t.index ["user_id"], name: "index_matches_on_user_id"
  end

  create_table "preference_forms", force: :cascade do |t|
    t.string "title"
    t.integer "num_prefs"
    t.integer "num_antiprefs"
    t.boolean "active"
    t.bigint "submissions", default: [], array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deadline"
  end

  create_table "preferences", force: :cascade do |t|
    t.bigint "selector_id"
    t.bigint "selected_id"
    t.bigint "preference_form_id"
    t.string "pref_type"
    t.integer "rating"
    t.text "why"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["preference_form_id"], name: "index_preferences_on_preference_form_id"
    t.index ["selected_id"], name: "index_preferences_on_selected_id"
    t.index ["selector_id"], name: "index_preferences_on_selector_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phonenumber"
    t.string "snapchat"
    t.string "instagram"
    t.string "facebook"
    t.string "twitter"
    t.string "ptanimal"
    t.string "pttruecolors"
    t.string "ptmyersbriggs"
    t.string "enneagram"
    t.string "aboutme"
    t.boolean "approvedchair"
    t.string "gender"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "preference_form_id"
    t.text "question"
    t.string "question_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["preference_form_id"], name: "index_questions_on_preference_form_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password"
    t.string "role"
    t.boolean "approved"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "encrypted_password", limit: 128
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128
    t.string "email_confirmation_token", default: "", null: false
    t.datetime "email_confirmed_at"
    t.string "name"
    t.index ["email"], name: "index_users_on_email"
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "choices", "questions"
  add_foreign_key "matches", "preference_forms"
end

# frozen_string_literal: true

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

<<<<<<< HEAD
ActiveRecord::Schema.define(version: 2021_03_19_220149) do

=======
ActiveRecord::Schema.define(version: 20_210_219_001_026) do
>>>>>>> 9c6381d10d1cd8279e447045d04d46e7559e8cfc
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

<<<<<<< HEAD
  create_table "answers", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "question_id"
    t.text "short_answer"
    t.boolean "true_false"
    t.integer "numeric"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
=======
  create_table 'answers', force: :cascade do |t|
    t.bigint 'user_id'
    t.bigint 'question_id'
    t.bigint 'preference_form_id'
    t.string 'answer_type'
    t.text 'short_answer'
    t.boolean 'true_false'
    t.integer 'numeric'
    t.string 'multiple_choice'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['preference_form_id'], name: 'index_answers_on_preference_form_id'
    t.index ['question_id'], name: 'index_answers_on_question_id'
    t.index ['user_id'], name: 'index_answers_on_user_id'
>>>>>>> 9c6381d10d1cd8279e447045d04d46e7559e8cfc
  end

  create_table 'choices', force: :cascade do |t|
    t.text 'content'
    t.bigint 'question_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['question_id'], name: 'index_choices_on_question_id'
  end

<<<<<<< HEAD
  create_table "preference_forms", force: :cascade do |t|
    t.bigint "creator_id"
    t.integer "num_prefs"
    t.integer "num_antiprefs"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["creator_id"], name: "index_preference_forms_on_creator_id"
  end

  create_table "preferences", force: :cascade do |t|
    t.bigint "selector_id"
    t.bigint "selected_id"
    t.string "pref_type"
    t.integer "rating"
    t.text "why"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
    t.string "aboutme"
    t.boolean "approvedchair"
    t.boolean "gender"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "enneagram"
  end

  create_table "questions", force: :cascade do |t|
    t.text "question"
    t.string "type"
    t.string "choices", array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
=======
  create_table 'preference_forms', force: :cascade do |t|
    t.bigint 'creator_id'
    t.string 'title'
    t.integer 'num_prefs'
    t.integer 'num_antiprefs'
    t.boolean 'active'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['creator_id'], name: 'index_preference_forms_on_creator_id'
  end

  create_table 'preferences', force: :cascade do |t|
    t.bigint 'selector_id'
    t.bigint 'selected_id'
    t.bigint 'preference_form_id'
    t.string 'pref_type'
    t.integer 'rating'
    t.text 'why'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['preference_form_id'], name: 'index_preferences_on_preference_form_id'
    t.index ['selected_id'], name: 'index_preferences_on_selected_id'
    t.index ['selector_id'], name: 'index_preferences_on_selector_id'
  end

  create_table 'profiles', force: :cascade do |t|
    t.string 'name'
    t.string 'email'
    t.string 'phonenumber'
    t.string 'snapchat'
    t.string 'instagram'
    t.string 'facebook'
    t.string 'twitter'
    t.string 'ptanimal'
    t.string 'pttruecolors'
    t.string 'ptmyersbriggs'
    t.string 'aboutme'
    t.boolean 'approvedchair'
    t.boolean 'gender'
    t.bigint 'user_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'questions', force: :cascade do |t|
    t.bigint 'preference_form_id'
    t.text 'question'
    t.string 'question_type'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['preference_form_id'], name: 'index_questions_on_preference_form_id'
>>>>>>> 9c6381d10d1cd8279e447045d04d46e7559e8cfc
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email'
    t.string 'password'
    t.string 'role'
    t.boolean 'approved'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'encrypted_password', limit: 128
    t.string 'confirmation_token', limit: 128
    t.string 'remember_token', limit: 128
    t.index ['email'], name: 'index_users_on_email'
    t.index ['remember_token'], name: 'index_users_on_remember_token'
  end

  add_foreign_key 'choices', 'questions'
end

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

ActiveRecord::Schema[8.1].define(version: 2014_08_21_074917) do
  create_table "answers", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.integer "question_id"
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "artists", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.integer "song_id"
    t.datetime "updated_at", null: false
    t.index ["song_id"], name: "index_artists_on_song_id"
  end

  create_table "assignments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "conferences", force: :cascade do |t|
    t.string "city"
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "emails", force: :cascade do |t|
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_emails_on_user_id"
  end

  create_table "people", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "description"
    t.string "name"
    t.integer "project_id"
    t.string "role"
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_people_on_project_id"
  end

  create_table "presentations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "duration"
    t.integer "speaker_id"
    t.string "topic"
    t.datetime "updated_at", null: false
    t.index ["speaker_id"], name: "index_presentations_on_speaker_id"
  end

  create_table "producers", force: :cascade do |t|
    t.integer "artist_id"
    t.datetime "created_at", null: false
    t.string "name"
    t.string "studio"
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_producers_on_artist_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "github_name"
    t.string "twitter_name"
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "project_tags", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "project_id"
    t.integer "tag_id"
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_project_tags_on_project_id"
    t.index ["tag_id"], name: "index_project_tags_on_tag_id"
  end

  create_table "projects", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "description"
    t.string "name"
    t.integer "owner_id"
    t.datetime "updated_at", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.integer "survey_id"
    t.datetime "updated_at", null: false
    t.index ["survey_id"], name: "index_questions_on_survey_id"
  end

  create_table "songs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "length"
    t.string "title"
    t.datetime "updated_at", null: false
  end

  create_table "speakers", force: :cascade do |t|
    t.integer "conference_id"
    t.datetime "created_at", null: false
    t.string "name"
    t.string "occupation"
    t.datetime "updated_at", null: false
    t.index ["conference_id"], name: "index_speakers_on_conference_id"
  end

  create_table "sub_tasks", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "description"
    t.boolean "done"
    t.string "name"
    t.integer "task_id"
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_sub_tasks_on_task_id"
  end

  create_table "surveys", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.integer "assignment_id"
    t.datetime "created_at", null: false
    t.string "description"
    t.boolean "done"
    t.string "name"
    t.integer "project_id"
    t.datetime "updated_at", null: false
    t.index ["assignment_id"], name: "index_tasks_on_assignment_id"
    t.index ["project_id"], name: "index_tasks_on_project_id"
  end

  create_table "users", force: :cascade do |t|
    t.integer "age"
    t.datetime "created_at", null: false
    t.integer "gender"
    t.string "name"
    t.datetime "updated_at", null: false
  end
end

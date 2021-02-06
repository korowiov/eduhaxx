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

ActiveRecord::Schema.define(version: 2021_02_06_101127) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "education_levels", force: :cascade do |t|
    t.string "title", null: false
    t.string "slug"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["slug"], name: "index_education_levels_on_slug"
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text "content"
    t.string "searchable_type"
    t.bigint "searchable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable"
  end

  create_table "question_options", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "quiz_question_id"
    t.string "content"
    t.boolean "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["quiz_question_id"], name: "index_question_options_on_quiz_question_id"
  end

  create_table "quiz_answers", force: :cascade do |t|
    t.uuid "quiz_session_id"
    t.uuid "quiz_question_id"
    t.uuid "question_option_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_option_id"], name: "index_quiz_answers_on_question_option_id"
    t.index ["quiz_question_id"], name: "index_quiz_answers_on_quiz_question_id"
    t.index ["quiz_session_id"], name: "index_quiz_answers_on_quiz_session_id"
  end

  create_table "quiz_questions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "quiz_id"
    t.string "content"
    t.string "question_type", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_type"], name: "index_quiz_questions_on_question_type"
    t.index ["quiz_id"], name: "index_quiz_questions_on_quiz_id"
  end

  create_table "quiz_sessions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "quiz_id"
    t.integer "score"
    t.datetime "finished_at"
    t.jsonb "configuration", default: {}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["quiz_id"], name: "index_quiz_sessions_on_quiz_id"
  end

  create_table "resource_subjects", force: :cascade do |t|
    t.bigint "subject_id"
    t.string "subjectable_type"
    t.uuid "subjectable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["subject_id"], name: "index_resource_subjects_on_subject_id"
    t.index ["subjectable_type", "subjectable_id"], name: "index_resource_subjects_on_subjectable"
  end

  create_table "resource_tags", force: :cascade do |t|
    t.bigint "tag_id"
    t.string "taggable_type"
    t.uuid "taggable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tag_id"], name: "index_resource_tags_on_tag_id"
    t.index ["taggable_type", "taggable_id"], name: "index_resource_tags_on_taggable"
  end

  create_table "resources", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "education_level_id"
    t.string "type"
    t.string "name", null: false
    t.text "description"
    t.string "state", default: "created", null: false
    t.datetime "published_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["education_level_id"], name: "index_resources_on_education_level_id"
    t.index ["state"], name: "index_resources_on_state"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "title", null: false
    t.string "slug"
    t.bigint "node_parent_id"
    t.integer "node_depth", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["node_parent_id"], name: "index_subjects_on_node_parent_id"
    t.index ["slug"], name: "index_subjects_on_slug"
  end

  create_table "tags", force: :cascade do |t|
    t.string "label"
    t.string "slug"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["label"], name: "index_tags_on_label"
    t.index ["slug"], name: "index_tags_on_slug"
  end

end

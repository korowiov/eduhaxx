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

ActiveRecord::Schema.define(version: 2021_01_29_231453) do

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

  create_table "resource_subjects", force: :cascade do |t|
    t.uuid "resource_id"
    t.bigint "subject_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["resource_id"], name: "index_resource_subjects_on_resource_id"
    t.index ["subject_id"], name: "index_resource_subjects_on_subject_id"
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

end

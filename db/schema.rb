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

ActiveRecord::Schema[7.1].define(version: 2024_04_11_201138) do
  create_table "notes", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.integer "project_paper_id"
    t.integer "paper_id"
    t.text "quote"
    t.text "note"
    t.integer "position"
    t.integer "rank"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["paper_id"], name: "index_notes_on_paper_id"
    t.index ["position"], name: "index_notes_on_position"
    t.index ["project_paper_id"], name: "index_notes_on_project_paper_id"
    t.index ["rank"], name: "index_notes_on_rank"
    t.index ["type"], name: "index_notes_on_type"
  end

  create_table "papers", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "title"
    t.integer "year_published"
    t.string "publisher"
    t.text "content"
    t.binary "pdf"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["publisher"], name: "index_papers_on_publisher"
    t.index ["year_published"], name: "index_papers_on_year_published"
  end

  create_table "project_papers", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.integer "project_id"
    t.integer "paper_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["paper_id"], name: "index_project_papers_on_paper_id"
    t.index ["project_id"], name: "index_project_papers_on_project_id"
  end

  create_table "projects", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "index_projects_on_title"
  end

end

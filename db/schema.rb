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

ActiveRecord::Schema[7.0].define(version: 2023_02_20_030137) do
  create_table "working_documents", force: :cascade do |t|
    t.string "owner", null: false
    t.string "repo_name", null: false
    t.integer "issue_number", null: false
    t.string "issue_title", null: false
    t.boolean "pull", null: false
    t.text "body", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner", "repo_name", "issue_number"], name: "index_working_documents_on_owner_and_repo_name_and_issue_number"
  end

end

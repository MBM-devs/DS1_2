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

ActiveRecord::Schema[7.0].define(version: 2022_05_26_193812) do
  create_table "followed_lists", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "list_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["list_id"], name: "index_followed_lists_on_list_id"
    t.index ["user_id"], name: "index_followed_lists_on_user_id"
  end

  create_table "followings", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "follower", null: false
    t.bigint "followed", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed"], name: "followed_fk"
    t.index ["follower"], name: "follower_fk"
  end

  create_table "ingredients", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lists", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_lists_on_user_id"
  end

  create_table "projects", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.integer "team", null: false
    t.text "info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team"], name: "index_projects_on_team", unique: true
  end

  create_table "recipe_ingredients", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.integer "quantity"
    t.string "unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_recipe_ingredients_on_recipe_id"
  end

  create_table "recipes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.integer "people"
    t.integer "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shopping_lists", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "ingredient_id", null: false
    t.boolean "comprado"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_shopping_lists_on_ingredient_id"
    t.index ["user_id"], name: "index_shopping_lists_on_user_id"
  end

  create_table "steps", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "index"
    t.string "description"
    t.bigint "recipe_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_steps_on_recipe_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "username", null: false
    t.string "email", null: false
    t.string "password", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "followed_lists", "lists"
  add_foreign_key "followed_lists", "users"
  add_foreign_key "followings", "users", column: "followed", name: "followed_fk"
  add_foreign_key "followings", "users", column: "follower", name: "follower_fk"
  add_foreign_key "lists", "users"
  add_foreign_key "recipe_ingredients", "recipes"
  add_foreign_key "shopping_lists", "ingredients"
  add_foreign_key "shopping_lists", "users"
  add_foreign_key "steps", "recipes"
end
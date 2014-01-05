# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140104054511) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: true do |t|
    t.integer  "user_id"
    t.string   "uid"
    t.string   "username"
    t.string   "oauth_token"
    t.string   "oauth_secret"
    t.datetime "oauth_expires"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
  end

  add_index "accounts", ["user_id"], name: "index_accounts_on_user_id", using: :btree

  create_table "conversations", force: true do |t|
    t.integer  "lesson_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "conversations", ["lesson_id"], name: "index_conversations_on_lesson_id", using: :btree

  create_table "lessons", force: true do |t|
    t.integer  "skill_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "learning_request"
    t.integer  "{:index=>true}_id"
    t.boolean  "approved",          default: false
    t.boolean  "ignored",           default: false
    t.boolean  "completed",         default: false
    t.integer  "user_id"
  end

  add_index "lessons", ["skill_id"], name: "index_lessons_on_skill_id", using: :btree
  add_index "lessons", ["user_id"], name: "index_lessons_on_user_id", using: :btree

  create_table "messages", force: true do |t|
    t.text     "body"
    t.text     "subject"
    t.integer  "sender"
    t.integer  "receiver"
    t.boolean  "read",            default: false
    t.integer  "conversation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["conversation_id"], name: "index_messages_on_conversation_id", using: :btree

  create_table "receipts", force: true do |t|
    t.integer  "user_id"
    t.integer  "conversation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "read",            default: false
  end

  add_index "receipts", ["conversation_id"], name: "index_receipts_on_conversation_id", using: :btree
  add_index "receipts", ["user_id"], name: "index_receipts_on_user_id", using: :btree

  create_table "reviews", force: true do |t|
    t.text     "message"
    t.boolean  "thumb"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "stars"
    t.integer  "lesson_id"
    t.integer  "target_user_id"
  end

  add_index "reviews", ["lesson_id"], name: "index_reviews_on_lesson_id", using: :btree
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id", using: :btree

  create_table "skills", force: true do |t|
    t.string   "title"
    t.text     "qualifications"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.string   "picture"
    t.boolean  "approved",       default: false
    t.boolean  "hidden",         default: false
  end

  add_index "skills", ["user_id"], name: "index_skills_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "learning_request"
    t.string   "picture"
    t.boolean  "admin",            default: false
    t.text     "bio"
    t.text     "learn"
    t.text     "interest"
    t.string   "school"
    t.string   "work"
    t.string   "filepicker_url"
    t.string   "location"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end

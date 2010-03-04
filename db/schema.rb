# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100304154218) do

  create_table "comments", :force => true do |t|
    t.integer  "creator_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "file_attachments", :force => true do |t|
    t.integer  "proposal_id"
    t.string   "attachment_file_file_name"
    t.string   "attachment_file_file_content_type"
    t.integer  "attachment_file_file_size"
    t.datetime "attachment_file_file_updated_at"
  end

  create_table "inspiration_images", :force => true do |t|
    t.string   "image_file_file_name"
    t.string   "image_file_content_type"
    t.integer  "image_file_file_size"
    t.datetime "image_file_updated_at"
    t.integer  "inspiration_id"
  end

  create_table "inspirations", :force => true do |t|
    t.string  "title"
    t.string  "description"
    t.string  "url"
    t.integer "project_id"
  end

  create_table "projects", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "slug"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "proposal_images", :force => true do |t|
    t.string   "image_file_file_name"
    t.string   "image_file_content_type"
    t.integer  "image_file_file_size"
    t.datetime "image_file_updated_at"
    t.integer  "proposal_id"
  end

  create_table "proposals", :force => true do |t|
    t.integer "product_id"
    t.integer "version_number"
    t.integer "project_id"
    t.text    "content"
    t.string  "image_file_file_name"
    t.string  "image_file_content_type"
    t.integer "image_file_file_size"
    t.integer "creator_id"
  end

  create_table "uploads", :force => true do |t|
    t.integer  "user_id"
    t.string   "content_type"
    t.string   "filename"
    t.string   "thumbnail"
    t.integer  "size"
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "votes", :force => true do |t|
    t.boolean  "vote",          :default => false
    t.integer  "voteable_id",                      :null => false
    t.string   "voteable_type",                    :null => false
    t.integer  "voter_id"
    t.string   "voter_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["voteable_id", "voteable_type"], :name => "fk_voteables"
  add_index "votes", ["voter_id", "voter_type"], :name => "fk_voters"

end

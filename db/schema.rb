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

ActiveRecord::Schema.define(version: 20150324153335) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "certificates", force: :cascade do |t|
    t.string   "claimable_uri"
    t.string   "claimable_type"
    t.string   "template_pdf"
    t.string   "template_background_image"
    t.string   "certificate_type"
    t.float    "available_credit"
    t.string   "eligibility"
    t.date     "expiration_date"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "claims", force: :cascade do |t|
    t.string   "key"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "product_name"
    t.string   "certificate_url"
    t.string   "credit_type"
    t.float    "claimed_credit"
    t.json     "survey_data"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "prerequisites", force: :cascade do |t|
    t.integer  "certificate_id"
    t.integer  "survey_id"
    t.string   "survey_order"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "surveys", force: :cascade do |t|
    t.string   "title"
    t.json     "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end

class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.string :user_uri
      t.json :payload

      t.timestamps null: false
    end
  end
end

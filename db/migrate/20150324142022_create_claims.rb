class CreateClaims < ActiveRecord::Migration
  def change
    create_table :claims do |t|
      t.string :key
      t.string :first_name
      t.string :last_name
      t.string :product_name
      t.string :certificate_url
      t.string :credit_type
      t.float :claimed_credit
      t.json :survey_data

      t.timestamps null: false
    end
  end
end

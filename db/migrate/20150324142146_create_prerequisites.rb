class CreatePrerequisites < ActiveRecord::Migration
  def change
    create_table :prerequisites do |t|
      t.integer :certificate_id
      t.integer :survey_id
      t.string :survey_order

      t.timestamps null: false
    end
  end
end

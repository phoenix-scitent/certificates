class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :title
      t.json :data

      t.timestamps null: false
    end
  end
end

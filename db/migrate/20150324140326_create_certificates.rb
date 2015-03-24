class CreateCertificates < ActiveRecord::Migration
  def change
    create_table :certificates do |t|
      t.string :claimable_uri
      t.string :claimable_type
      t.string :template_pdf
      t.string :template_background_image
      t.string :certificate_type
      t.float :available_credit
      t.string :eligibility
      t.date :expiration_date

      t.timestamps null: false
    end
  end
end

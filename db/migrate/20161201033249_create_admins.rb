class CreateAdmins < ActiveRecord::Migration[5.0]
  def change
    create_table :admins do |t|
      t.string :email
      t.string :token
      t.references :wedding, foreign_key: true

      t.timestamps
    end
  end
end

class CreateGuests < ActiveRecord::Migration[5.0]
  def change
    create_table :guests do |t|
      t.string :first_name
      t.string :last_name
      t.boolean :rsvp, default: false
      t.boolean :plus_one, default: false

      t.timestamps
    end
  end
end

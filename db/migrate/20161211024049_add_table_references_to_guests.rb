class AddTableReferencesToGuests < ActiveRecord::Migration[5.0]
  def change
    add_reference :guests, :table, foreign_key: true
  end
end

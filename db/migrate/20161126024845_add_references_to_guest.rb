class AddReferencesToGuest < ActiveRecord::Migration[5.0]
  def change
    add_reference :guests, :wedding, foreign_key: true
  end
end

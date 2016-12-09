class RemoveDeeefaultFromGuests < ActiveRecord::Migration[5.0]
  def change
    change_column_default(:guests, :plus_one, nil)
  end
end

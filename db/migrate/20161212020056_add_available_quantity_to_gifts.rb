class AddAvailableQuantityToGifts < ActiveRecord::Migration[5.0]
  def change
    add_column :gifts, :available_quantity, :integer
  end
end

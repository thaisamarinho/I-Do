class ChangeColumnInGuestTable < ActiveRecord::Migration[5.0]
  def change
    remove_column :guests, :first_name, :string
    remove_column :guests, :last_name, :string
    add_column :guests, :name, :string
  end
end

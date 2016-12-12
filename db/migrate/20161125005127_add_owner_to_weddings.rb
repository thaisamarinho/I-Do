class AddOwnerToWeddings < ActiveRecord::Migration[5.0]
  def change
    add_reference(:weddings, :owner, foreign_key: { to_table: :users })
  end
end

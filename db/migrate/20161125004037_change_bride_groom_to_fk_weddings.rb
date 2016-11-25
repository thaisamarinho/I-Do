class ChangeBrideGroomToFkWeddings < ActiveRecord::Migration[5.0]
  def change
    remove_column :weddings, :bride
    remove_column :weddings, :groom

    add_reference(:weddings, :bride, foreign_key: {to_table: :users})
    add_reference(:weddings, :groom, foreign_key: {to_table: :users})
  end
end

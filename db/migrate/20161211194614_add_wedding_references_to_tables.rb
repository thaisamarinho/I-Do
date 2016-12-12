class AddWeddingReferencesToTables < ActiveRecord::Migration[5.0]
  def change
    add_reference :tables, :wedding, foreign_key: true
  end
end

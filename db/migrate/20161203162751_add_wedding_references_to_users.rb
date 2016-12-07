class AddWeddingReferencesToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :wedding, foreign_key: true
  end
end

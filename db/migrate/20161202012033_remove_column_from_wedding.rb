class RemoveColumnFromWedding < ActiveRecord::Migration[5.0]
  def change
    remove_column :weddings, :bride_id
    remove_column :weddings, :groom_id
  end
end

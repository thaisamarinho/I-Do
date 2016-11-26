class AddReferencesToService < ActiveRecord::Migration[5.0]
  def change
    add_reference :services, :wedding, foreign_key: true
  end
end

class CreateGifts < ActiveRecord::Migration[5.0]
  def change
    create_table :gifts do |t|
      t.string :item
      t.text :description
      t.string :image, array: true, default: []
      t.integer :quantity
      t.references :wedding, foreign_key: true

      t.timestamps
    end
  end
end

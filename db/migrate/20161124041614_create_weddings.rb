class CreateWeddings < ActiveRecord::Migration[5.0]
  def change
    create_table :weddings do |t|
      t.integer :bride
      t.integer :groom
      t.integer :budget
      t.date :date

      t.timestamps
    end
  end
end

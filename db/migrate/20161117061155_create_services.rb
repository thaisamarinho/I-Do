class CreateServices < ActiveRecord::Migration[5.0]
  def change
    create_table :services do |t|
      t.string :vendor
      t.float :price
      t.float :budget
      t.boolean :chosen, default: false

      t.timestamps
    end
  end
end

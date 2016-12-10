class AddStoryToWeddings < ActiveRecord::Migration[5.0]
  def change
    add_column :weddings, :story, :text
  end
end

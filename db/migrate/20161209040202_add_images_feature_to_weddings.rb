class AddImagesFeatureToWeddings < ActiveRecord::Migration[5.0]
  def change
    add_column :weddings, :images, :string, array: true, default: []
  end
end

class AddColumnLinkToGifts < ActiveRecord::Migration[5.0]
  def change
    add_column :gifts, :link, :text
  end
end

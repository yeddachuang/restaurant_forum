class FixColumnNameCategoryIdInRestaurants < ActiveRecord::Migration[5.2]
  def change
    rename_column :restaurants, :catefory_id, :category_id
  end
end

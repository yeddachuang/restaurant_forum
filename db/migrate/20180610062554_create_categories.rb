class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :name
      t.timestamps
    end

    add_column :restaurants, :catefory_id, :integer
  end
end

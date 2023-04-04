class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.integer :post_id, null: false
      t.string :name,  null: false
      t.timestamps
    end
  end
end

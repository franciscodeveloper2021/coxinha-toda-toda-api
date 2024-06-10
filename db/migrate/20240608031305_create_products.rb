class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :photo_url, null: false
      t.string :name, null: false
      t.text :description
      t.float :price, null: false
      t.boolean :available, null: false
      t.references :sector, null: false, foreign_key: true

      t.timestamps
    end

    add_index :products, 'LOWER(name)', unique: true, name: 'index_products_on_lower_name'
  end
end

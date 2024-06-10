class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name, null: false, limit: 50
      t.text :description, limit: 500
      t.float :price, null: false
      t.boolean :available, null: false, default: true
      t.references :sector, null: false, foreign_key: true

      t.timestamps
    end

    add_index :products, 'LOWER(name)', unique: true, name: 'index_products_on_lower_name'
  end
end

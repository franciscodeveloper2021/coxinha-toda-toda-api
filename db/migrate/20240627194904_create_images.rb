class CreateImages < ActiveRecord::Migration[7.1]
  def change
    create_table :images do |t|
      t.text :description, limit: 500
      t.references :imageable, polymorphic: true, null: false

      t.timestamps
    end
  end
end

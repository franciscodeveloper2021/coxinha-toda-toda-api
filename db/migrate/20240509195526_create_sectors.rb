class CreateSectors < ActiveRecord::Migration[7.1]
  def change
    create_table :sectors do |t|
      t.string :name, null: false, limit: 50

      t.timestamps
    end

    execute <<-SQL
      ALTER TABLE sectors ADD CONSTRAINT min_length_name CHECK (LENGTH(name) >= 5);

      CREATE UNIQUE INDEX index_sectors_on_lower_name ON sectors (LOWER(name));
    SQL

    add_index :sectors, :name, unique: true
  end
end

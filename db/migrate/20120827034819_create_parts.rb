class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.integer :team_id, null: false
      t.integer :part_type_id, null: false
      t.integer :part_year, null: false
      t.string :part_identifier, null: false

      t.timestamps
    end

    add_index :parts, :team_id
    add_index :parts, :part_type_id
    add_index :parts, :part_year
    add_index :parts, :part_identifier, unique: true
  end
end

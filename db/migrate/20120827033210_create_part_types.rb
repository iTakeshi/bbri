class CreatePartTypes < ActiveRecord::Migration
  def change
    create_table :part_types do |t|
      t.string :type_name, null:false

      t.timestamps
    end

    add_index :part_types, :type_name, unique: true

    PartType.create!(id: 1, type_name: 'unknown')
  end
end

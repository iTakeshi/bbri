class AddPartDescriptionToParts < ActiveRecord::Migration
  def change
    add_column :parts, :part_description, :string
  end
end

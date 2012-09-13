class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :part_id, null: false
      t.integer :user_id, null: false
      t.string :review_title, null: false
      t.text :review_text, null: false

      t.timestamps
    end

    add_index :reviews, :part_id
  end
end

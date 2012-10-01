class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id, null: false
      t.integer :review_id, null: false
      t.text :comment_text, null: false
      t.integer :good_counter, null: false, default: 0

      t.timestamps
    end

    add_index :comments, :review_id
  end
end

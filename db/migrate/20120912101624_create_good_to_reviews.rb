class CreateGoodToReviews < ActiveRecord::Migration
  def change
    create_table :good_to_reviews do |t|
      t.integer :review_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end

class CreateReviewsUsers < ActiveRecord::Migration
  def change
    create_table :reviews_users do |t|
      t.integer :review_id, null: false
      t.integer :user_id, null: false
      t.integer :eval, null: false

      t.timestamps
    end
  end
end

class AddScoreToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :good_count, :integer, null: false, default: 0
    add_column :reviews, :bad_count, :integer, null: false, default: 0
  end
end

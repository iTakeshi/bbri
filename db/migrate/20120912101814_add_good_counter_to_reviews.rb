class AddGoodCounterToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :good_counter, :integer, null: false, default: 0
  end
end

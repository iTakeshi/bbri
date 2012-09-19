class AddIsQuestionToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :is_question, :boolean, null: false, default: false
  end
end

class RemovePictureFromReviews < ActiveRecord::Migration[5.1]
  def change
    remove_column :reviews, :picture, :string
  end
end

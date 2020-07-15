class AddPictureToReviews < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :picture, :string, default: 'https://i.pinimg.com/originals/04/9c/71/049c7119abe6ab1b777005ea84777b78.jpg'
  end
end

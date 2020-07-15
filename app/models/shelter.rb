class Shelter < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip
  has_many :pets
  has_many :reviews

  def total_pets
    pets.count
  end

  def average_review_rating
    reviews.average(:rating).to_f
  end

  def pet_applications_on_file
    pets.sum {|pet| pet.applications.count}
  end
end

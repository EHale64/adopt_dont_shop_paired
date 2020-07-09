class Shelter < ApplicationRecord
  validates_presence_of :name
  has_many :pets
  has_many :reviews

  def total_pets
    pets.count
  end
end

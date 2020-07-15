class Pet < ApplicationRecord
  validates_presence_of :name, :age, :sex, :image, :description
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications

  def change_status
    if self.status == "Adoptable"
      self.status = "Pending"
    else
      self.status = "Adoptable"
    end
  end
end

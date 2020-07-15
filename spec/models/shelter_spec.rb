require 'rails_helper'

RSpec.describe Shelter do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
  end
  describe 'relationships' do
    it { should have_many :pets }
    it { should have_many :reviews }
  end

  describe 'methods' do
    it '#total_pets' do
      shelter_1 = Shelter.create!(name: 'Pets, Pets, Pets', address: '123 Easy St', city: 'Denver', state: 'CO', zip: '80204')
      shelter_2 = Shelter.create!(name: 'Got A Lotta Pets', address: '456 EzPz Ln', city: 'LVegas', state: 'NV', zip: '12345')
      pet_1 = shelter_1.pets.create!(name: 'Charles Barkley', age: 3, sex: 'Male', image: 'rhodesian.jpg', description: 'Rhodesian Ridgeback')
      pet_2 = shelter_1.pets.create!(name: 'Karl Barx', age: 2, sex: 'Male', image: 'airedale.jpg', description: 'Airedale Terrier')
      pet_3 = shelter_2.pets.create!(name: 'Sarah Jessica Barker', age: 4, sex: 'Female', image: 'dalmatian.jpg', description: 'Dalmation')

      expect(shelter_1.total_pets).to eq(2)
      expect(shelter_2.total_pets).to eq(1)
    end

    it '#average_review_rating' do
      shelter_1 = Shelter.create!(name: 'Pets, Pets, Pets', address: '123 Easy St', city: 'Denver', state: 'CO', zip: '80204')
      review_1 = shelter_1.reviews.create!(title: 'hello', rating: 4, content: 'hello again')
      review_2 = shelter_1.reviews.create!(title: 'review_2', rating: 3, content: 'great pets')
      review_3 = shelter_1.reviews.create!(title: 'lotta pets up in here', rating: 2, content: 'so many pets')

      expect(shelter_1.average_review_rating).to eq(3.0)
    end

    it '#pet_applications_on_file' do
      shelter_1 = Shelter.create!(name: 'Pets, Pets, Pets', address: '123 Easy St', city: 'Denver', state: 'CO', zip: '80204')
      pet_1 = shelter_1.pets.create!(name: 'Charles Barkley', age: 3, sex: 'Male', image: 'rhodesian.jpg', description: 'Rhodesian Ridgeback')
      application_1 = Application.create!(name: "Jackie Chan",address: "123 South Dr.",city: "Denver",state: "CO.",zip: "12345",phone_number: "123-456-7890",description: "No one will take better care of these pets!")
      application_2 = Application.create!(name: "Chris Tucker",address: "123 North Dr.",city: "Denver",state: "CO.",zip: "12345",phone_number: "343-234-2325",description: "I'll take better care of these pets than Jackie Chan!")
      pet_application_1 = PetApplication.create!(pet_id: pet_1.id, application_id: application_1.id)
      pet_application_2 = PetApplication.create!(pet_id: pet_1.id, application_id: application_2.id)

      expect(shelter_1.pet_applications_on_file).to eq(2)
    end
  end
end

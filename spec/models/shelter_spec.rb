require 'rails_helper'

RSpec.describe Shelter do
  describe 'validations' do
    it { should validate_presence_of :name }
  end
  describe 'relationships' do
    it { should have_many :pets }
    it { should have_many :reviews }
  end

  describe 'methods' do
    it '#total' do
      shelter_1 = Shelter.create!(name: 'Pets, Pets, Pets', address: '123 Easy St', city: 'Denver', state: 'CO', zip: '80204')
      shelter_2 = Shelter.create!(name: 'Got A Lotta Pets', address: '456 EzPz Ln', city: 'LVegas', state: 'NV', zip: '12345')
      pet_1 = shelter_1.pets.create!(name: 'Charles Barkley', age: 3, sex: 'Male', image: 'rhodesian.jpg', description: 'Rhodesian Ridgeback')
      pet_2 = shelter_1.pets.create!(name: 'Karl Barx', age: 2, sex: 'Male', image: 'airedale.jpg', description: 'Airedale Terrier')
      pet_3 = shelter_2.pets.create!(name: 'Sarah Jessica Barker', age: 4, sex: 'Female', image: 'dalmatian.jpg', description: 'Dalmation')

      expect(shelter_1.total_pets).to eq(2)
      expect(shelter_2.total_pets).to eq(1)
    end
  end
end

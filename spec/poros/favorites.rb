require 'rails_helper'

RSpec.describe Favorites do
  describe "methods" do
    it "#initialize" do
      shelter_1 = Shelter.create!(name: 'Pets, Pets, Pets', address: '123 Easy St', city: 'Denver', state: 'CO', zip: '80204')
      pet_1 = shelter_1.pets.create!(name: 'Charles Barkley', age: 3, sex: 'Male', image: 'rhodesian.jpg', description: 'Rhodesian Ridgeback')
      pet_2 = shelter_1.pets.create!(name: 'Miss Tripsalot', age: 2, sex: 'Female', image: 'rhodesian.jpg', description: 'Rhodesian Ridgeback')

      least_favorite_pets = Favorites.new(nil)

      most_favorite_pets = Favorites.new([pet_1.id, pet_2.id])

      expect(least_favorite_pets.pets).to eq([])
      expect(most_favorite_pets.pets).to eq([pet_1, pet_2])
    end

    it "#add_pet" do
      shelter_1 = Shelter.create!(name: 'Pets, Pets, Pets', address: '123 Easy St', city: 'Denver', state: 'CO', zip: '80204')
      pet_1 = shelter_1.pets.create!(name: 'Charles Barkley', age: 3, sex: 'Male', image: 'rhodesian.jpg', description: 'Rhodesian Ridgeback')
      pet_2 = shelter_1.pets.create!(name: 'Miss Tripsalot', age: 2, sex: 'Female', image: 'rhodesian.jpg', description: 'Rhodesian Ridgeback')

      new_favorites = Favorites.new([pet_1.id])
      new_favorites.add_pet(pet_2)

      expect(new_favorites.pets).to eq([pet_1, pet_2])
    end

    it "#remove_pet" do
      shelter_1 = Shelter.create!(name: 'Pets, Pets, Pets', address: '123 Easy St', city: 'Denver', state: 'CO', zip: '80204')
      pet_1 = shelter_1.pets.create!(name: 'Charles Barkley', age: 3, sex: 'Male', image: 'rhodesian.jpg', description: 'Rhodesian Ridgeback')
      pet_2 = shelter_1.pets.create!(name: 'Miss Tripsalot', age: 2, sex: 'Female', image: 'rhodesian.jpg', description: 'Rhodesian Ridgeback')
      our_favorite_pets = Favorites.new([pet_1.id, pet_2.id])

      our_favorite_pets.remove_pet(pet_1)
      expect(our_favorite_pets.pets).to eq([pet_2])
    end
  end
end

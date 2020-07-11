require 'rails_helper'

RSpec.describe 'When a user adds a pet to their favorites' do
  it 'the favorites count in the top navigation bar shows how many pets have been favorited' do
    shelter_1 = Shelter.create!(name: 'Pets, Pets, Pets', address: '123 Easy St', city: 'Denver', state: 'CO', zip: '80204')
    pet_1 = shelter_1.pets.create!(name: 'Charles Barkley', age: 3, sex: 'Male', image: 'https://i.pinimg.com/originals/b3/84/a8/b384a8a6f79ebc1d592e285aec698382.jpg', description: 'Rhodesian Ridgeback')
    pet_2 = shelter_1.pets.create!(name: 'Karl Barx', age: 2, sex: 'Male', image: 'https://i.pinimg.com/originals/01/23/29/0123299fb527e5b05ce0ab4649f0ec5d.jpg', description: 'Airedale Terrier')

    visit "/pets/#{pet_1.id}"

    within(".topnav") do
      expect(page).to have_content("Favorites: 0")
    end

    click_button "Add to Favorites"

    within(".topnav") do
      expect(page).to have_content("Favorites: 1")
    end

    visit "/pets/#{pet_2.id}"

    click_button "Add to Favorites"

    within(".topnav") do
      expect(page).to have_content("Favorites: 2")
    end
  end
end

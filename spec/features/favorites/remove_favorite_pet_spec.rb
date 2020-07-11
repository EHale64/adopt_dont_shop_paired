require 'rails_helper'

RSpec.describe 'Pet show page' do
  it 'shows button to remove pet from favorites when a pet is favorited' do
    shelter_1 = Shelter.create!(name: 'Pets, Pets, Pets', address: '123 Easy St', city: 'Denver', state: 'CO', zip: '80204')
    pet_1 = shelter_1.pets.create!(name: 'Charles Barkley', age: 3, sex: 'Male', image: 'https://i.pinimg.com/originals/b3/84/a8/b384a8a6f79ebc1d592e285aec698382.jpg', description: 'Rhodesian Ridgeback')
    visit "/pets/#{pet_1.id}"

    click_on "Add to Favorites"

    expect(current_path).to eq("/pets/#{pet_1.id}")

    expect(page).to have_button("Remove from Favorites")
    expect(page).to_not have_button("Add to Favorites")
  end

  it 'deletes the pet from favorites when the Remove from Favorites button is clicked' do
    shelter_1 = Shelter.create!(name: 'Pets, Pets, Pets', address: '123 Easy St', city: 'Denver', state: 'CO', zip: '80204')
    pet_1 = shelter_1.pets.create!(name: 'Charles Barkley', age: 3, sex: 'Male', image: 'https://i.pinimg.com/originals/b3/84/a8/b384a8a6f79ebc1d592e285aec698382.jpg', description: 'Rhodesian Ridgeback')
    visit "/pets/#{pet_1.id}"

    click_on "Add to Favorites"

    expect(current_path).to eq("/pets/#{pet_1.id}")

    within(".topnav") do
      expect(page).to have_content("Favorites: 1")
    end

    click_button "Remove from Favorites"

    expect(current_path).to eq("/pets/#{pet_1.id}")

    expect(page).to have_content("#{pet_1.name} removed from favorites.")

    within(".topnav") do
      expect(page).to have_content("Favorites: 0")
    end
  end

  it 'allows the user to remove a pet from favorites page' do
    shelter_1 = Shelter.create!(name: 'Pets, Pets, Pets', address: '123 Easy St', city: 'Denver', state: 'CO', zip: '80204')
    pet_1 = shelter_1.pets.create!(name: 'Charles Barkley', age: 3, sex: 'Male', image: 'https://i.pinimg.com/originals/b3/84/a8/b384a8a6f79ebc1d592e285aec698382.jpg', description: 'Rhodesian Ridgeback')
    pet_2 = shelter_1.pets.create!(name: 'Karl Barx', age: 2, sex: 'Male', image: 'https://i.pinimg.com/originals/01/23/29/0123299fb527e5b05ce0ab4649f0ec5d.jpg', description: 'Airedale Terrier')
    visit "/pets/#{pet_1.id}"
    click_button "Add to Favorites"
    visit "/pets/#{pet_2.id}"
    click_button "Add to Favorites"

    visit "/favorites"

    expect(page).to have_content("#{pet_1.name}")
    expect(page).to have_content("#{pet_2.name}")

    within "#favorite-#{pet_2.id}" do
      click_button "Remove from Favorites"
    end

    expect(current_path).to eq("/favorites")

    expect(page).to have_content("#{pet_1.name}")
    expect(page).to_not have_content("img[@src='#{pet_2.image}']")
  end
end

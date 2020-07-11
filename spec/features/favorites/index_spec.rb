require 'rails_helper'

RSpec.describe 'Favorites index page' do
  it 'displays all favorited pets' do
    shelter_1 = Shelter.create!(name: 'Pets, Pets, Pets', address: '123 Easy St', city: 'Denver', state: 'CO', zip: '80204')
    pet_1 = shelter_1.pets.create!(name: 'Charles Barkley', age: 3, sex: 'Male', image: 'https://i.pinimg.com/originals/b3/84/a8/b384a8a6f79ebc1d592e285aec698382.jpg', description: 'Rhodesian Ridgeback')
    pet_2 = shelter_1.pets.create!(name: 'Karl Barx', age: 2, sex: 'Male', image: 'https://i.pinimg.com/originals/01/23/29/0123299fb527e5b05ce0ab4649f0ec5d.jpg', description: 'Airedale Terrier')
    visit "/pets/#{pet_1.id}"

    click_on "Add to Favorites"

    visit "/favorites"

    expect(page).to have_css('.favorite', count: 1)

    within "#favorite-#{pet_1.id}" do
      expect(page).to have_css("img[@src='https://i.pinimg.com/originals/b3/84/a8/b384a8a6f79ebc1d592e285aec698382.jpg']")
      expect(page).to have_content("#{pet_1.name}")
    end

    visit "/pets/#{pet_2.id}"

    click_on "Add to Favorites"

    visit "/favorites"

    expect(page).to have_css('.favorite', count: 2)

    within "#favorite-#{pet_2.id}" do
      expect(page).to have_css("img[@src='https://i.pinimg.com/originals/01/23/29/0123299fb527e5b05ce0ab4649f0ec5d.jpg']")
      expect(page).to have_content("#{pet_2.name}")
    end
  end

  it 'displays a message indicating that they have no favorited pets' do
    visit "/favorites"

    expect(page).to have_content("You haven't favorited any pets!")
  end

  it 'has a button to delete all pets from favorites' do
    shelter_1 = Shelter.create!(name: 'Pets, Pets, Pets', address: '123 Easy St', city: 'Denver', state: 'CO', zip: '80204')
    pet_1 = shelter_1.pets.create!(name: 'Charles Barkley', age: 3, sex: 'Male', image: 'https://i.pinimg.com/originals/b3/84/a8/b384a8a6f79ebc1d592e285aec698382.jpg', description: 'Rhodesian Ridgeback')
    pet_2 = shelter_1.pets.create!(name: 'Karl Barx', age: 2, sex: 'Male', image: 'https://i.pinimg.com/originals/01/23/29/0123299fb527e5b05ce0ab4649f0ec5d.jpg', description: 'Airedale Terrier')

    visit "/pets/#{pet_1.id}"

    click_on "Add to Favorites"

    visit "/pets/#{pet_2.id}"

    click_on "Add to Favorites"

    visit "/favorites"

    click_on "Delete All Favorites"

    expect(current_path).to eq("/favorites")

    expect(page).to have_content("You haven't favorited any pets!")
  end
end

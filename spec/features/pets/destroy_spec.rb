require 'rails_helper'

RSpec.describe 'Pet show page' do
  it 'allows the user to delete the selected pet' do
    shelter_1 = Shelter.create!(name: 'Pets, Pets, Pets', address: '123 Easy St', city: 'Denver', state: 'CO', zip: '80204')
    shelter_2 = Shelter.create!(name: 'Got A Lotta Pets', address: '456 EzPz Ln', city: 'LVegas', state: 'NV', zip: '12345')
    pet_1 = shelter_1.pets.create!(name: 'Charles Barkley', age: 3, sex: 'Male', image: 'rhodesian.jpg', description: 'Rhodesian Ridgeback')
    pet_2 = shelter_1.pets.create!(name: 'Karl Barx', age: 2, sex: 'Male', image: 'airedale.jpg', description: 'Airedale Terrier')
    pet_3 = shelter_2.pets.create!(name: 'Sarah Jessica Barker', age: 4, sex: 'Female', image: 'dalmatian.jpg', description: 'Dalmation')

    visit "/pets/#{pet_2.id}"

    click_button "Delete #{pet_2.name}"

    expect(current_path).to eq('/pets')
    expect(page).to have_content('Charles Barkley')
    expect(page).to have_content('Sarah Jessica Barker')
    expect(page).to_not have_content('Karl Barx')
  end
end

require 'rails_helper'

RSpec.describe 'Pets index page' do
  it 'displays all pets to the user' do
    shelter_1 = Shelter.create!(name: 'Pets, Pets, Pets', address: '123 Easy St', city: 'Denver', state: 'CO', zip: '80204')
    shelter_2 = Shelter.create!(name: 'Got A Lotta Pets', address: '456 EzPz Ln', city: 'LVegas', state: 'NV', zip: '12345')
    pet_1 = shelter_1.pets.create!(name: 'Charles Barkley', age: 3, sex: 'Male', image: 'rhodesian.jpg', description: 'Rhodesian Ridgeback')
    pet_2 = shelter_1.pets.create!(name: 'Karl Barx', age: 2, sex: 'Male', image: 'airedale.jpg', description: 'Airedale Terrier')
    pet_3 = shelter_2.pets.create!(name: 'Sarah Jessica Barker', age: 4, sex: 'Female', image: 'dalmatian.jpg', description: 'Dalmation')

    visit '/pets'

    expect(page).to have_content(pet_1.name)
    expect(page).to have_content("Shelter: #{shelter_1.name}")
    expect(page).to have_content("Age: #{pet_1.age}")
    expect(page).to have_content("Sex: #{pet_1.sex}")
    expect(page).to have_content(pet_2.name)
    expect(page).to have_content("Shelter: #{shelter_1.name}")
    expect(page).to have_content("Age: #{pet_2.age}")
    expect(page).to have_content("Sex: #{pet_2.sex}")
    expect(page).to have_content(pet_3.name)
    expect(page).to have_content("Shelter: #{shelter_2.name}")
    expect(page).to have_content("Age: #{pet_3.age}")
    expect(page).to have_content("Sex: #{pet_3.sex}")
  end
end

# expect(page).to have_css("img[src*='#{pet_3.image}']")

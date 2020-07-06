require 'rails_helper'

RSpec.describe 'Pets show page' do
  it 'displays image, name, description, age, sex, and adoption status for a particular pet to the user' do
    shelter_1 = Shelter.create!(name: 'Got A Lotta Pets', address: '456 EzPz Ln', city: 'LVegas', state: 'NV', zip: '12345')
    pet_1 = shelter_1.pets.create!(name: 'Charles Barkley', age: 3, sex: 'Male', image: 'rhodesian.jpg', description: 'Rhodesian Ridgeback')
    pet_2 = shelter_1.pets.create!(name: 'Karl Barx', age: 2, sex: 'Male', image: 'airedale.jpg', description: 'Airedale Terrier')

    visit "/pets/#{pet_1.id}"

    expect(page).to have_content("Name: #{pet_1.name}")
    expect(page).to have_content("Approximate Age: #{pet_1.age}")
    expect(page).to have_content("Sex: #{pet_1.sex}")
    expect(page).to have_content("Description: #{pet_1.description}")
    expect(page).to have_content("Adoption Status: #{pet_1.status}")
    expect(page).to_not have_content("#{pet_2.name}")
  end
end

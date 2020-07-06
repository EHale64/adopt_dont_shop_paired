require 'rails_helper'

RSpec.describe "Shelter's pets index page" do
  it 'allows the user to add a new adoptable pet to the shelter' do
    shelter_1 = Shelter.create!(name: 'Pets, Pets, Pets', address: '123 Easy St', city: 'Denver', state: 'CO', zip: '80204')
    pet_1 = shelter_1.pets.create!(name: 'Charles Barkley', age: 3, sex: 'Male', image: 'rhodesian.jpg', description: 'Rhodesian Ridgeback')

    visit "/shelters/#{shelter_1.id}/pets"

    expect(page).to have_content("#{pet_1.name}")
    expect(page).to_not have_content("Karl Barx")

    click_button 'Add Pet'

    expect(current_path).to eq("/shelters/#{shelter_1.id}/pets/new")

    fill_in :name, with: 'Karl Barx'
    fill_in :age, with: 2
    fill_in :description, with: 'Airedale Terrier'
    select 'Male', :from => 'sex'
    fill_in :image, with: 'airedale.jpg'

    click_on 'Add Pet'

    expect(current_path).to eq("/shelters/#{shelter_1.id}/pets")
    expect(page).to have_content('Karl Barx')
    expect(page).to have_content('Adoptable')
  end
end

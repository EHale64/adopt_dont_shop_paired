require 'rails_helper'

RSpec.describe "On a pet's show page" do
  it "has a link to show all applications for this pet with a link to each applications' show page" do
    shelter_1 = Shelter.create!(name: 'Got A Lotta Pets', address: '456 EzPz Ln', city: 'LVegas', state: 'NV', zip: '12345')
    pet_1 = shelter_1.pets.create!(name: 'Charles Barkley', age: 3, sex: 'Male', image: 'rhodesian.jpg', description: 'Rhodesian Ridgeback')
    pet_2 = shelter_1.pets.create!(name: 'Karl Barx', age: 2, sex: 'Male', image: 'airedale.jpg', description: 'Airedale Terrier')
    application = Application.create!(name: "Jackie Chan",address: "123 South Dr.",city: "Denver",state: "CO.",zip: "12345",phone_number: "123-456-7890",description: "No one will take better care of these pets!")
    pet_application = PetApplication.create!(pet_id: pet_1.id, application_id: application.id)

    visit "/pets/#{pet_1.id}"

    click_link "View Applications"

    expect(current_path).to eq("/pets/#{pet_1.id}/applications")

    click_link("Jackie Chan")
    expect(current_path).to eq("/applications/#{application.id}")
  end

  it "displays a message when it has no applications" do
    shelter_1 = Shelter.create!(name: 'Got A Lotta Pets', address: '456 EzPz Ln', city: 'LVegas', state: 'NV', zip: '12345')
    pet_1 = shelter_1.pets.create!(name: 'Charles Barkley', age: 3, sex: 'Male', image: 'rhodesian.jpg', description: 'Rhodesian Ridgeback')
    pet_2 = shelter_1.pets.create!(name: 'Karl Barx', age: 2, sex: 'Male', image: 'airedale.jpg', description: 'Airedale Terrier')

    visit "/pets/#{pet_1.id}"

    click_link "View Applications"

    expect(current_path).to eq("/pets/#{pet_1.id}/applications")

    expect(page).to have_content("This pet has no applicants to adopt. Help them find a forever home!")
  end
end

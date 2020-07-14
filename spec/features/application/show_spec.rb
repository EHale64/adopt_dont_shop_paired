require 'rails_helper'

RSpec.describe "Application show page" do
  it "displays info" do

    shelter_1 = Shelter.create!(name: 'Pets, Pets, Pets', address: '123 Easy St', city: 'Denver', state: 'CO', zip: '80204')
    pet_1 = shelter_1.pets.create!(name: 'Charles Barkley', age: 3, sex: 'Male', image: 'https://i.pinimg.com/originals/b3/84/a8/b384a8a6f79ebc1d592e285aec698382.jpg', description: 'Rhodesian Ridgeback')
    pet_2 = shelter_1.pets.create!(name: 'Karl Barx', age: 2, sex: 'Male', image: 'https://i.pinimg.com/originals/01/23/29/0123299fb527e5b05ce0ab4649f0ec5d.jpg', description: 'Airedale Terrier')
    application = Application.create!(name: "Jackie Chan",address: "123 South Dr.",city: "Denver",state: "CO.",zip: "12345",phone_number: "123-456-7890",description: "No one will take better care of these pets!")
    pet_application = PetApplication.create!(pet_id: pet_1.id, application_id: application.id)
    visit "/pets/#{pet_1.id}"

    click_button "Add to Favorites"

    visit "/pets/#{pet_2.id}"

    click_button "Add to Favorites"

    visit "/applications/#{application.id}"

    expect(page).to have_content("Jackie Chan")
    expect(page).to have_content("123 South Dr.")
    expect(page).to have_content("Denver")
    expect(page).to have_content("CO.")
    expect(page).to have_content("12345")
    expect(page).to have_content("123-456-7890")
    expect(page).to have_content("No one will take better care of these pets!")
    expect(page).to have_link("Charles Barkley")
  end

  it "has links to approve applications for each pet" do
    shelter_1 = Shelter.create!(name: 'Pets, Pets, Pets', address: '123 Easy St', city: 'Denver', state: 'CO', zip: '80204')
    pet_1 = shelter_1.pets.create!(name: 'Charles Barkley', age: 3, sex: 'Male', image: 'https://i.pinimg.com/originals/b3/84/a8/b384a8a6f79ebc1d592e285aec698382.jpg', description: 'Rhodesian Ridgeback')
    pet_2 = shelter_1.pets.create!(name: 'Karl Barx', age: 2, sex: 'Male', image: 'https://i.pinimg.com/originals/01/23/29/0123299fb527e5b05ce0ab4649f0ec5d.jpg', description: 'Airedale Terrier')
    application = Application.create!(name: "Jackie Chan",address: "123 South Dr.",city: "Denver",state: "CO.",zip: "12345",phone_number: "123-456-7890",description: "No one will take better care of these pets!")
    pet_application = PetApplication.create!(pet_id: pet_1.id, application_id: application.id)

    visit "/pets/#{pet_1.id}"

    click_button "Add to Favorites"

    visit "/pets/#{pet_2.id}"

    click_button "Add to Favorites"

    visit "/applications/#{application.id}"

    click_button "Approve Application"

    expect(current_path).to eq("/pets/#{pet_1.id}")

    expect(page).to have_content("Pending")
    expect(page).to have_content("On hold for #{application.name}")
  end
end

require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "when I have added pets to my favorites page" do
    it "has a link to apply for adoptions" do
      shelter_1 = Shelter.create!(name: 'Pets, Pets, Pets', address: '123 Easy St', city: 'Denver', state: 'CO', zip: '80204')
      pet_1 = shelter_1.pets.create!(name: 'Charles Barkley', age: 3, sex: 'Male', image: 'https://i.pinimg.com/originals/b3/84/a8/b384a8a6f79ebc1d592e285aec698382.jpg', description: 'Rhodesian Ridgeback')
      pet_2 = shelter_1.pets.create!(name: 'Karl Barx', age: 2, sex: 'Male', image: 'https://i.pinimg.com/originals/01/23/29/0123299fb527e5b05ce0ab4649f0ec5d.jpg', description: 'Airedale Terrier')
        visit "/pets/#{pet_1.id}"

        click_button "Add to Favorites"

        visit "/pets/#{pet_2.id}"

        click_button "Add to Favorites"

        visit "/favorites"

        click_on "Apply to adopt pets!"

        expect(current_path).to eq("/applications/new")

        expect(page).to have_content(pet_1.name)
        expect(page).to have_content(pet_2.name)

        check "#{pet_1.name}"
        fill_in :name, with: "Jackie Chan"
        fill_in :address, with: "123 South Dr."
        fill_in :city, with: "Denver"
        fill_in :state, with: "CO."
        fill_in :zip, with: "12345"
        fill_in :phone_number, with: "123-456-7890"
        fill_in :description, with: "No one will take better care of these pets!"

        click_button "Submit applicaition"

        expect(current_path).to eq("/favorites")
        
        expect(page).to have_content("Application submitted!")
        expect(page).to_not have_css("img[@src='https://i.pinimg.com/originals/b3/84/a8/b384a8a6f79ebc1d592e285aec698382.jpg']")
    end
  end
end

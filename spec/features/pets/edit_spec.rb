require 'rails_helper'

RSpec.describe 'Pet show page' do
  it "allows the user to follow a link to update the pet's info" do
    shelter_1 = Shelter.create!(name: 'Got A Lotta Pets', address: '456 EzPz Ln', city: 'LVegas', state: 'NV', zip: '12345')
    pet_1 = shelter_1.pets.create!(name: 'Sarah Jessica Barker', age: 4, sex: 'Female', image: 'dalmatian.jpg', description: 'Dalmation')

    visit "/pets/#{pet_1.id}"

    click_button "Edit #{pet_1.name} Info"

    expect(current_path).to eq("/pets/#{pet_1.id}/edit")

    fill_in :name, with: 'Bark Twain'
    fill_in :age, with: 5
    fill_in :description, with: 'Dalmation Puppy'
    select 'Male', :from => 'sex'

    click_on 'Update Pet Info'

    expect(current_path).to eq("/pets/#{pet_1.id}")

    expect(page).to have_content('Name: Bark Twain')
    expect(page).to have_content('Approximate Age: 5')
    expect(page).to have_content('Description: Dalmation Puppy')
    expect(page).to have_content('Sex: Male')
    expect(page).to_not have_content('Sarah Jessica Barker')
    expect(page).to_not have_content('Sex: Female')
  end
end

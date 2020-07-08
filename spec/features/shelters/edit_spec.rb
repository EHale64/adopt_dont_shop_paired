require 'rails_helper'

RSpec.describe 'Shelters index page' do
  it 'allows the user to follow the link to update the shelter info' do
    shelter_1 = Shelter.create(name: 'Pets, Pets, Pets', address: '123 Easy St', city: 'Denver', state: 'CO', zip: '80204')

    visit '/shelters'

    expect(page).to_not have_content('All Your Pets Are Belong to Us')

    click_button "Edit #{shelter_1.name} Info"

    expect(current_path).to eq("/shelters/#{shelter_1.id}/edit")

    fill_in :name, with: 'All Your Pets Are Belong to Us'

    click_on 'Update Shelter Info'

    expect(current_path).to eq("/shelters/#{shelter_1.id}")
    expect(page).to have_content('All Your Pets Are Belong to Us')
  end
end

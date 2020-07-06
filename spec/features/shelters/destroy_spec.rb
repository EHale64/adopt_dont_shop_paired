require 'rails_helper'

RSpec.describe 'Shelter index page' do
  it 'allows the user to delete the selected shelter' do
    shelter_1 = Shelter.create(name: 'Pets, Pets, Pets', address: '123 Easy St', city: 'Denver', state: 'CO', zip: '80204')
    shelter_2 = Shelter.create(name: 'Got A Lotta Pets', address: '456 EzPz Ln', city: 'LVegas', state: 'NV', zip: '12345')

    visit '/shelters'

    expect(page).to have_content('Got A Lotta Pets')

    click_button "Delete #{shelter_2.name}"

    expect(current_path).to eq('/shelters')
    expect(page).to_not have_content('Got A Lotta Pets')
    expect(page).to have_content('Pets, Pets, Pets')
  end
end

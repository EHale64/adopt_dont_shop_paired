require 'rails_helper'

RSpec.describe 'Shelters show page' do
  it 'displays name, address, city, state, and zip for a particular shelter to the user' do
    shelter_1 = Shelter.create(name: 'Pets, Pets, Pets', address: '123 Easy St', city: 'Denver', state: 'CO', zip: '80204')
    shelter_2 = Shelter.create(name: 'Got A Lotta Pets', address: '456 EzPz Ln', city: 'LVegas', state: 'NV', zip: '12345')

    visit "/shelters/#{shelter_1.id}"

    expect(page).to have_content(shelter_1.name)
    expect(page).to have_content("#{shelter_1.address} #{shelter_1.city}, #{shelter_1.state} #{shelter_1.zip}")
    expect(page).to_not have_content(shelter_2.name)
  end
end

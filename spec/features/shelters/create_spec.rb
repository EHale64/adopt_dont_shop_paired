require 'rails_helper'

RSpec.describe 'Shelters index page' do
  it 'allows the user to follow the link to create a new shelter' do
    visit '/shelters'

    expect(page).to_not have_content('All Your Pets Are Belong to Us')

    click_button 'Create New Shelter'

    expect(current_path).to eq('/shelters/new')

    fill_in :name, with: 'All Your Pets Are Belong to Us'
    fill_in :address, with: '789 Downing St'
    fill_in :city, with: 'Denver'
    fill_in :state, with: 'CO'
    fill_in :zip, with: '80204'

    click_on 'Create Shelter'

    expect(current_path).to eq('/shelters')
    expect(page).to have_content('All Your Pets Are Belong to Us')
  end
end

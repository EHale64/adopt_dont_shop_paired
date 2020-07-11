require 'rails_helper'

RSpec.describe "Shelter's show page" do
  it 'displays name, address, city, state, and zip for a particular shelter to the user' do
    shelter_1 = Shelter.create!(name: 'Pets, Pets, Pets', address: '123 Easy St', city: 'Denver', state: 'CO', zip: '80204')
    shelter_2 = Shelter.create!(name: 'Got A Lotta Pets', address: '456 EzPz Ln', city: 'LVegas', state: 'NV', zip: '12345')

    visit "/shelters/#{shelter_1.id}"

    expect(page).to have_content(shelter_1.name)
    expect(page).to have_content("#{shelter_1.address} #{shelter_1.city}, #{shelter_1.state} #{shelter_1.zip}")
    expect(page).to_not have_content(shelter_2.name)
  end

  describe "Shelter's show page" do
    it 'displays shelter reviews' do
      shelter_1 = Shelter.create!(name: 'Pets, Pets, Pets', address: '123 Easy St', city: 'Denver', state: 'CO', zip: '80204')
      review_1 = shelter_1.reviews.create(title: "Great place to find a new best friend!!!!", rating: 5, content: "Found my new best friend here. Sir fluffington the 3rd is the fluffiest!", picture: "https://img.thedailybeast.com/image/upload/c_crop,d_placeholder_euli9k,h_675,w_1200,x_0,y_0/dpr_2.0/c_limit,w_740/fl_lossy,q_auto/v1585178360/200325-Teeman-adopting-pets-tease_enredw")
      visit "/shelters/#{shelter_1.id}"

      expect(page).to have_content("Reviews:")
      expect(page).to have_content("Great place to find a new best friend!!!!")
      expect(page).to have_content("Rating: 5/5")
      expect(page).to have_content("Found my new best friend here. Sir fluffington the 3rd is the fluffiest!")
    end
  end
end

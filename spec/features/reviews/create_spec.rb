require 'rails_helper'

RSpec.describe 'review creation page' do
  it "allows the user to create a new review" do
    shelter_1 = Shelter.create(name: 'Pets, Pets, Pets', address: '123 Easy St', city: 'Denver', state: 'CO', zip: '80204')

    visit "/shelters/#{shelter_1.id}"

    click_button "Add review"

    expect(current_path).to eq("/shelters/#{shelter_1.id}/reviews/new")

    fill_in :title, with: "Great place to find a new best friend!!!!"
    fill_in :content, with: "Found my new best friend here. Sir fluffington the 3rd is the fluffiest!"
    fill_in :rating, with: 5
    fill_in :picture, with: "https://img.thedailybeast.com/image/upload/c_crop,d_placeholder_euli9k,h_675,w_1200,x_0,y_0/dpr_2.0/c_limit,w_740/fl_lossy,q_auto/v1585178360/200325-Teeman-adopting-pets-tease_enredw"

    click_on "Submit review"

    expect(current_path).to eq("/shelters/#{shelter_1.id}")

    expect(page).to have_content("Reviews:")
    expect(page).to have_content("Great place to find a new best friend!!!!")
    expect(page).to have_content("5/5")
    expect(page).to have_content("Found my new best friend here. Sir fluffington the 3rd is the fluffiest!")
    #expect(page).to have_css("img[src*='https://img.thedailybeast.com/image/upload/c_crop,d_placeholder_euli9k,h_675,w_1200,x_0,y_0/dpr_2.0/c_limit,w_740/fl_lossy,q_auto/v1585178360/200325-Teeman-adopting-pets-tease_enredw']")
  end
end

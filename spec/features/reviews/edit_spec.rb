require 'rails_helper'

RSpec.describe 'edit review page' do

  before :all do
    @shelter_1 = Shelter.create(name: 'Pets, Pets, Pets', address: '123 Easy St', city: 'Denver', state: 'CO', zip: '80204')
    @review_1 = @shelter_1.reviews.create(title: "Great place to find a new best friend!!!!", rating: 5, content: "Found my new best friend here. Sir fluffington the 3rd is the fluffiest!", picture: "https://img.thedailybeast.com/image/upload/c_crop,d_placeholder_euli9k,h_675,w_1200,x_0,y_0/dpr_2.0/c_limit,w_740/fl_lossy,q_auto/v1585178360/200325-Teeman-adopting-pets-tease_enredw")
  end
  it "can edit a previously made review" do
    visit "/shelters/#{@shelter_1.id}"

    click_on("Edit review")

    expect(current_path).to eq("/reviews/#{@review_1.id}/edit")

    fill_in :title, with: "The dogs need more legs!"

    click_on "Update review"

    expect(current_path).to eq("/shelters/#{@shelter_1.id}")

    expect(page).to have_content("The dogs need more legs!")
    expect(page).to_not have_content("Great place to find a new best friend!!!!")
  end
  
  it "produces a flash error message when title, content, and rating are not filled in" do
    visit "/shelters/#{@shelter_1.id}"

    click_on("Edit review")

    expect(current_path).to eq("/reviews/#{@review_1.id}/edit")

    fill_in :title, with: ""

    click_on "Update review"

    expect(current_path).to eq("/reviews/#{@review_1.id}/edit")

    expect(page).to have_content("You must fill out Title, Rating, and Content to submit a review.")
  end
end

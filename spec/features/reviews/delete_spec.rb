require 'rails_helper'

RSpec.describe 'delete a review' do
  # before :each do
  #   @shelter_1 = Shelter.create(name: 'Pets, Pets, Pets', address: '123 Easy St', city: 'Denver', state: 'CO', zip: '80204')
  #   @review_1 = @shelter_1.reviews.create(title: "Great place to find a new best friend!!!!", rating: 5, content: "Found my new best friend here. Sir fluffington the 3rd is the fluffiest!", picture: "https://img.thedailybeast.com/image/upload/c_crop,d_placeholder_euli9k,h_675,w_1200,x_0,y_0/dpr_2.0/c_limit,w_740/fl_lossy,q_auto/v1585178360/200325-Teeman-adopting-pets-tease_enredw")
  #   @review_2 = @shelter_1.reviews.create(title: "Lovely", rating: 4, content: "Couldn't find a pet!", picture: "")
  # end

  it "can delete a review" do
    shelter_1 = Shelter.create!(name: 'Pets, Pets, Pets', address: '123 Easy St', city: 'Denver', state: 'CO', zip: '80204')
    review_1 = shelter_1.reviews.create!(title: "Great place to find a new best friend!!!!", rating: 5, content: "Found my new best friend here. Sir fluffington the 3rd is the fluffiest!", picture: "https://img.thedailybeast.com/image/upload/c_crop,d_placeholder_euli9k,h_675,w_1200,x_0,y_0/dpr_2.0/c_limit,w_740/fl_lossy,q_auto/v1585178360/200325-Teeman-adopting-pets-tease_enredw")
    review_2 = shelter_1.reviews.create!(title: "Lovely", rating: 4, content: "Couldn't find a pet!", picture: "")
    visit "/shelters/#{shelter_1.id}"

    expect(page).to have_content("Great place to find a new best friend!!!!")

    expect(page).to have_content("Lovely")

    find(".delete-review", match: :first).click

    expect(current_path).to eq("/shelters/#{shelter_1.id}")

    expect(page).to_not have_content("Great place to find a new best friend!!!!")
  end
end

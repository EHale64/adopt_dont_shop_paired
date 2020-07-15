class SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
  end

  def show
    @shelter = Shelter.find(params[:id])
    @reviews = @shelter.reviews
    if params[:sort] == 'Lowest to Highest'
      @reviews = @shelter.reviews.order(:rating)
    elsif params[:sort] == 'Highest to Lowest'
      @reviews = @shelter.reviews.order(rating: :desc).order(:created_at)
    end
  end

  def new
  end

  def create
    shelter = Shelter.new(shelter_params)
    if shelter.save
      redirect_to '/shelters'
    else
      flash[:error] = 'You must fill out all fields to create a shelter!'
      redirect_to request.referrer
    end
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    shelter = Shelter.find(params[:id])
    shelter.update(shelter_params)
    if shelter.save
      redirect_to "/shelters/#{shelter.id}"
    else
      flash[:error] = "You must fill out all fields to update this shelter's information!"
      redirect_to request.referrer
    end
  end

  def destroy
    shelter = Shelter.find(params[:id])
    pets_status = shelter.pets.any? {|pet| pet.status == 'Pending'}
    if pets_status
      flash[:error] = 'Shelter cannot be deleted because it has pet(s) with pending adoptions!'
      redirect_to '/shelters'
    else
      shelter.pets.each do |pet|
        pet.pet_applications.destroy_all
        pet.destroy
      end
      shelter.reviews.destroy_all
      shelter.destroy
      redirect_to '/shelters'
    end
  end

  def pets
    @shelter = Shelter.find(params[:id])
  end

  private

  def shelter_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end

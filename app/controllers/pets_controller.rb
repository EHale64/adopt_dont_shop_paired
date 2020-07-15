class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def new
    @shelter_id = params[:shelter_id]
  end

  def create
    Pet.create(pet_params)
    redirect_to "/shelters/#{params[:shelter_id]}/pets"
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id])
    if request.referrer.last(4) == "edit"
      pet.update(pet_params)
      if pet.save
        redirect_to "/pets/#{pet.id}"
      else
        redirect_to request.referrer
        flash[:error] = "You must fill out all fields to update this pet's info!"
      end
    elsif pet.status == "Adoptable" && request.referrer.last(4) != "edit"
      pet.change_status
      pet.save
      redirect_to "/pets/#{pet.id}"
    elsif pet.status == "Pending"
      pet.change_status
      pet.save
      redirect_to request.referrer
    end
  end

  def destroy
    pet = Pet.find(params[:id])
    if pet.status == 'Pending'
      flash[:error] = "This pet cannot be deleted while its adoption status is pending!"
      redirect_to request.referrer
    else
      favorites = Favorites.new(session[:favorites])
      favorites.pet_ids.delete(pet.id)
      pet.applications.destroy_all
      pet.destroy
      redirect_to '/pets'
    end
  end

  private

  def pet_params
    params.permit(:name, :age, :sex, :description, :image, :status, :shelter_id)
  end
end

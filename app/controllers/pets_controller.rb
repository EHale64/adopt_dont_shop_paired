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
    else
      pet.change_status
      pet.save
    end
    if pet.status == "Adoptable" && request.referrer.last(4) != "edit"
      redirect_to request.referrer
    else
      redirect_to "/pets/#{pet.id}"
    end
  end

  def destroy
    Pet.destroy(params[:id])
    redirect_to '/pets'
  end

  private

  def pet_params
    params.permit(:name, :age, :sex, :description, :image, :status, :shelter_id)
  end
end

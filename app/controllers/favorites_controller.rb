class FavoritesController < ApplicationController
  def index
    @favorites = Favorites.new(session[:favorites])
    @pet_apps = PetApplication.all
  end

  def update
    pet = Pet.find(params[:pet_id])
    favorites = Favorites.new(session[:favorites])
    favorites.add_pet(pet)
    session[:favorites] = favorites.pet_ids
    #require "pry"; binding.pry
    flash[:notice] = "#{pet.name} added to favorites!"
    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    pet = Pet.find(params[:pet_id])
    favorites = Favorites.new(session[:favorites])
    favorites.remove_pet(pet)
    flash[:notice] = "#{pet.name} removed from favorites."
    redirect_to request.referrer
  end

  def destroy_all
    reset_session
    redirect_to request.referrer
  end
end

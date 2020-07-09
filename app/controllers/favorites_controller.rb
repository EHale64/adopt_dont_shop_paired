class FavoritesController < ApplicationController
  def update
    pet = Pet.find(params[:pet_id])
    session[:favorites] ||= []
    session[:favorites] << pet.id
    flash[:notice] = "Added pet to favorites!"
    redirect_to "/pets/#{pet.id}"
  end
end

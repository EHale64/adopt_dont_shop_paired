class FavoritesController < ApplicationController
  def index
    if session[:favorites].nil?
      @favorites = 0
    else
      @favorites = session[:favorites].map {|favorite| Pet.find(favorite)}
    end
  end

  def update
    pet = Pet.find(params[:pet_id])
    session[:favorites] ||= []
    session[:favorites] << pet.id
    flash[:notice] = "#{pet.name} added to favorites!"
    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    pet = Pet.find(params[:pet_id])
    session[:favorites].delete(pet.id)
    flash[:notice] = "#{pet.name} removed from favorites."
    redirect_to request.referrer
  end

  def destroy_all
    reset_session
    redirect_to request.referrer
  end
end

class ApplicationsController < ApplicationController
  def new
    @favorites = session[:favorites].map {|favorite| Pet.find(favorite)}
  end

  def create
    Application.create(application_params)
    pet_ids = params[:applications][:pet_ids]
    pet_ids.each do |pet_id|
      #require "pry"; binding.pry
      session[:favorites].delete(pet_id.to_i) #if session[:favorites].include?(pet_id)
    end
    redirect_to "/favorites"
    flash[:notice] = "Application submitted!"
  end

  private
  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end
end

# <label class="checkbox-inline">
#   <input type="checkbox" value=""> <%= favorite.name %>
# </label>

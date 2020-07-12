class ApplicationsController < ApplicationController
  def new
    @favorites = session[:favorites].map {|favorite| Pet.find(favorite)}
  end

  def create
    require "pry"; binding.pry
    Application.create(application_params)
    redirect_to "/favorites"
    flash[:notice] = "Application submitted!"
  end

  private
  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end
end

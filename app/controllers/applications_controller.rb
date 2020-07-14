class ApplicationsController < ApplicationController
  def new
    @favorites = session[:favorites].map {|favorite| Pet.find(favorite)}
  end

  def create
    application = Application.new(application_params)
    pet_ids = params[:applications][:pet_ids]
    if application.save
      pet_ids.delete("")
      pet_ids.each do |pet_id|
        PetApplication.create(pet_id: pet_id, application_id: application.id)
        session[:favorites].delete(pet_id.to_i)
      end
      redirect_to "/favorites"
      flash[:notice] = "Application submitted!"
    else
      redirect_to request.referrer
      flash[:error] = "You must fill out each section of the form to submit an application!"
    end
  end

  def show
    @application = Application.find(params[:id])
  end

  def index
    pet = Pet.find(params[:pet_id])
    @applications = pet.applications
  end

  private
  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end
end

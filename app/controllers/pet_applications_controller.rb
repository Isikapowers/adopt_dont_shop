class PetApplicationsController < ApplicationController

  def new
  end

  def create
    @application = Application.find(params[:id])
    @pet = Pet.find(params[:id])
    PetApplication.create!(application: @application, pet: @pets)

    redirect_to "/applications/#{@application.id}"
  end

  def edit
  end

  def update
    application = Application.find(params[:id])
    pet_application = PetApplication.find_by_pet_and_app_id(params[:id], params[:pet_id])
    pet_application.update(pet_application_params)

    redirect_to "/admin/applications/#{application.id}"
  end


  private

  def pet_application_params
    params.permit(:status)
  end
  
end

class AdminApplicationsController < ApplicationController

  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
    @pet_applications = PetApplication.where(application_id: params[:id])

    if @pet_applications.all?{ |pet_app| pet_app.status == "Approved" }
      @application.update(status: "Approved")
    end
  end

  def update
    application = Application.find(params[:id])
    pets = Pet.find(params[:pet_id])
    pet_application = PetApplication.where(application_id: params[:id], pet_id: pets.id)

    if params[:status] == "rejected"
      pet_application.update(status: "Rejected") && application.update(status: "Rejected")
    elsif params[:status] == "approved"
      pet_application.update(status: "Approved") && pets.update(adoptable: false)
    elsif pets.adoptable == false
      pet_application.update(status: "Rejected")
    end

    redirect_to "/admin/applications/#{application.id}"
  end

  def destroy
    application = Application.find(params[:id])
    pets = Pet.all
    pet_application = PetApplication.find_by_pet_and_app_id(application.id, pets.ids)
    pet_application.destroy

    redirect_to "/admin/applications"
  end


  private

  def update_params
    params.permit(:status, :id)
  end

end

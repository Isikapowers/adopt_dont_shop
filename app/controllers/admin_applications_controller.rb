class AdminApplicationsController < ApplicationController

  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
    @pets = Pet.all
    @pet_application = PetApplication.find(params[:id])

    if params[:status] == "rejected"
      @application.update_attribute(:status, "Rejected")
    elsif params[:status] == "approved"
      @application.update_attribute(:status, "Approved") && @application.pets.update_all(adoptable: false)
    elsif @pets.adoptable == false
      @application.update_attribute(:status, "Rejected")
    end
  end


  private

  def update_params
    params.permit(:status, :id)
  end

end

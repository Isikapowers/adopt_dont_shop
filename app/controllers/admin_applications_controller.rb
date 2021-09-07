class AdminApplicationsController < ApplicationController

  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
    @pets = Pet.all
    @pet_application = PetApplication.find(params[:id])

    if params[:status] == "rejected"
      @pet_application.update_attribute(:status, "Rejected") &&
      @application.update_attribute(:status, "Rejected")
    elsif params[:status] == "approved"
      @pet_application.update_attribute(:status, "Approved") &&
      @application.update_attribute(:status, "Approved") &&
      @application.pets.update_all(adoptable: false)
    elsif @pets.adoptable == false
      @pet_application.update_attribute(:status, "Rejected") &&
      @application.update_attribute(:status, "Rejected")
    end
  end


  private

  def update_params
    params.permit(:status, :id)
  end

end

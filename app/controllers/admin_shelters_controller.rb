class AdminSheltersController < ApplicationController

  def index
    @shelters = Shelter.order_by_name_in_reverse
    @shelters_pending = Shelter.pending_applications
  end

  def show
    @shelter = Shelter.find(params[:id])
    @pets = Pet.all
    @pet_application = PetApplication.all

    if params[:status] == "rejected"
      @pet_application.update_attribute(:status, "Rejected") && @application.update_attribute(:status, "Rejected")
    elsif params[:status] == "approved"
      @pet_application.update_attribute(:status, "Approved") && @application.update_attribute(:status, "Approved") && @application.pets.update_all(adoptable: false)
    end
  end

end

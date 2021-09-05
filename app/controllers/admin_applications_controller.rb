class AdminApplicationsController < ApplicationController

  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
    @pet_application = PetApplication.all

    if @pet_application.status_list_by_application(@application.id).include?('Rejected') &&
      @pet_application.status_list_by_application(@application.id).exclude?('Pending')
      @application.update(status: 'Rejected')
    elsif @pet_application.status_list_by_application(@application.id).include?('Approved') &&
      @pet_application.status_list_by_application(@application.id).exclude?('Pending')
      @application.update(status: 'Approved')
      @application.pets.update_all(adoptable: false)
    end
  end

end

class AdminSheltersController < ApplicationController

  def index
    @shelters = Shelter.order_by_name_in_reverse
    @shelters_pending = Shelter.pending_applications
  end

  def show
    @shelter = Shelter.find(params[:id])
    @pets = Pet.all
  end

end

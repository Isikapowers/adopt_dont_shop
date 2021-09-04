class ShelterPetsController < ApplicationController

  def index
    @shelter = Shelter.find(params[:shelter_id])
    @pets = @shelter.pets.all

    if params[:sort] == 'alphabetical'
      @pets = @pets.alphabetical_pets
    elsif params[:age]
      @pets= @pets.shelter_pets_filtered_by_age(params[:age])
    else
      @pets= @pets.adoptable
    end
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

end

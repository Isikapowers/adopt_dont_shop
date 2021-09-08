require 'rails_helper'

RSpec.describe PetApplication, type: :model do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', address: "2345 Main Street", city: "Aurora", state: "CO", zipcode: "46352", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', address: "4573 South Street", city: "Harlingen", state: "TX", zipcode: "57253", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', address: "84 Peticle Street", city: "Denver", state: "CO", zipcode: "74529", foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @pet_4 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)

    @app = Application.create!(applicant_name: "Condi Crawford", applicant_street_address: "223 Cindi Street", applicant_city: "Denver", applicant_state: "CO", applicant_zipcode: "45435")
    @pet_app = PetApplication.create!(application: @app, pet: @pet_1)
  end

  describe 'relationships' do
    it { should belong_to(:pet) }
    it { should belong_to(:application) }
  end

  describe "Class Methods" do
    it "can find a pet application by pet id and app is" do
      expect(PetApplication.find_by_pet_and_app_id(@app.id, @pet_1.id)).to eq(@pet_app)
    end

    it "can list the status of an application" do
      expect(PetApplication.status_list_by_application(@app.id)).to eq(["Pending"])
    end
  end

end

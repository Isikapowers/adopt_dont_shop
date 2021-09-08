require 'rails_helper'

RSpec.describe Application, type: :model do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', address: "2345 Main Street", city: "Aurora", state: "CO", zipcode: "46352", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', address: "4573 South Street", city: "Harlingen", state: "TX", zipcode: "57253", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', address: "84 Peticle Street", city: "Denver", state: "CO", zipcode: "74529", foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @pet_4 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)

    @app = Application.create!(applicant_name: "Condi Crawford", applicant_street_address: "223 Cindi Street", applicant_city: "Denver", applicant_state: "CO", applicant_zipcode: "45435")
  end

  describe 'relationships' do
    it { should have_many(:pets).through (:pet_applications) }
    it { should have_many(:pet_applications) }
  end

  describe "if status is not in progress" do
    before { allow(subject).to receive(:status_not_in_progress?).and_return(true) }
    it { should validate_presence_of(:description) }

    # expect(@app.status_not_in_progress?).to eq(true)
  end

  describe "if status is in progress" do
    before { allow(subject).to receive(:status_not_in_progress?).and_return(false) }
    it { should_not validate_presence_of(:description) }

    # expect(@app.status_not_in_progress?).to eq(false)
  end

  describe ".order_by_id" do
    it "can display names in id order" do
      expect(Application.order_by_id).to eq([@app])
    end
    # expect(@app.status_not_in_progress?).to eq(false)
  end

  describe ".search_ny_name" do
    it "can search by names" do
      expect(Application.search_by_name("cl")).to eq([@pet_2.name])
    end
    # expect(@app.status_not_in_progress?).to eq(false)
  end
end

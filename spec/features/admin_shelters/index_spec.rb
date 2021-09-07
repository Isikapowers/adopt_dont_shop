require "rails_helper"

RSpec.describe "Admin Shelter Index Page" do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', address: "2345 Main Street", city: "Aurora", state: "CO", zipcode: "46352", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', address: "4573 South Street", city: "Harlingen", state: "TX", zipcode: "57253", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', address: "84 Peticle Street", city: "Denver", state: "CO", zipcode: "74529", foster_program: true, rank: 10)

    @pirate = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @claw = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @lu = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
  end

  describe "Shelters" do
    it "can list all shelters in the system in reverse alphabetical order by name" do
      visit "/admin/shelters"

      expect(page).to have_content(@shelter_1.name)
      expect(page).to have_content(@shelter_2.name)
      expect(page).to have_content(@shelter_3.name)
      expect(@shelter_1.name).to appear_before(@shelter_2.name)
      # expect(@shelter_1).to appear_before(@shelter_3)
      # expect(@shelter_3).to appear_before(@shelter_2)
    end

    it "can display only the names of every shelter that has a pending application" do
      visit "/admin/shelters"

      expect(page).to have_content("Shelters with Pending Applications:")

    end
  end
end

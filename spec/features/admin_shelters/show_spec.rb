require "rails_helper"

RSpec.describe "Admin Shelter Show Page" do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', address: "2345 Main Street", city: "Aurora", state: "CO", zipcode: "46352", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', address: "4573 South Street", city: "Harlingen", state: "TX", zipcode: "57253", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', address: "84 Peticle Street", city: "Denver", state: "CO", zipcode: "74529", foster_program: true, rank: 10)

    @pirate = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @claw = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @lu = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
  end

  describe "Database Logic Part 2" do
    it "displays that shelter's name and full address" do
      visit "/admin/shelters/#{@shelter_1.id}"

      expect(page).to have_content("Aurora shelter")
      expect(page).to have_content("2345 Main Street")
      expect(page).to have_content("Aurora")
      expect(page).to have_content("CO")
      expect(page).to have_content("46352")
    end
  end

  describe "Statistics" do
    it "can display shelters with pending applications listed Alphabetically" do
      visit "/admin/shelters"

      expect(page).to have_content("Shelters with Pending Applications:")
    end

    it "has a link to every shelter" do
      visit "/admin/shelters"

      expect(page).to have_link(@shelter_1.name)
      expect(page).to have_link(@shelter_2.name)
    end

    it "displays an average pet age" do
      visit "/admin/shelters/#{@shelter_1.id}"

      expect(page).to have_content("Average Pet Age: ")
      expect(page).to have_content("4")
    end

    it "displays a number of adoptable pets" do
      visit "/admin/shelters/#{@shelter_1.id}"

      expect(page).to have_content("Number of Adoptable Pets: ")
      expect(page).to have_content("2")
    end

    it "displays a number of adopted pets" do
      visit "/admin/shelters/#{@shelter_1.id}"

      expect(page).to have_content("Number of Adopted Pets: ")
      expect(page).to have_content("0")
    end
  end

  describe "Action Required Section" do
    it "has a action required section" do
      visit "/admin/shelters/#{@shelter_1.id}"

      expect(page).to have_content("Action Required")
      # expect(page).to have_content(@shelter_1.pets)
    end
  end
end

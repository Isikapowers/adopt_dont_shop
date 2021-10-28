require "rails_helper"

RSpec.describe "Admin Application Show Page" do
  before :each do
    @shelter_1 = Shelter.create!(name: 'Aurora shelter', address: "2345 Main Street", city: "Aurora", state: "CO", zipcode: "46352", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: 'RGV animal shelter', address: "4573 South Street", city: "Harlingen", state: "TX", zipcode: "57253", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', address: "84 Peticle Street", city: "Denver", state: "CO", zipcode: "74529", foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald')
    @pet_2 = @shelter_1.pets.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster')
    @pet_3 = @shelter_2.pets.create!(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle')

    @dean = Application.create!(applicant_name: "Dean Dumdun",
                                applicant_street_address: "123 Main Street",
                                applicant_city: "Denver",
                                applicant_state: "CO",
                                applicant_zipcode: "56789",
                                description: "I already have a dog and would love for him to have friends",
                                status: "In Progress")
    @pet_app = PetApplication.create!(application: @dean, pet: @pet_1)
  end

  describe "Admin Applications" do
    it "can display all applications" do
      visit "admin/applications" do

        expect(page).to have_content(@dean)
      end
    end

    it "has a button to approve" do
      visit "/admin/applications/#{@dean.id}"

      click_button "Approve Application"

      expect(page).to_not have_button("Approve Application")
      expect(current_path).to eq("/admin/applications/#{@dean.id}")
    end

    it "has a button to reject" do
      visit "/admin/applications/#{@dean.id}"

      click_button "Reject Application"

      expect(page).to_not have_button("Reject Application")
      expect(current_path).to eq("/admin/applications/#{@dean.id}")
    end

    it "changes an application status to rejected when adoptable is false" do
      visit "/admin/applications/#{@dean.id}"

      expect(page).to have_button("Reject Application")
      expect(current_path).to eq("/admin/applications/#{@dean.id}")
    end
  end
end

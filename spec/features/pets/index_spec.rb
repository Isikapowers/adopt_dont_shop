require 'rails_helper'

RSpec.describe 'the pets index' do
  before :each do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', address: "2345 Main Street", city: "Aurora", state: "CO", zipcode: "46352", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', address: "4573 South Street", city: "Harlingen", state: "TX", zipcode: "57253", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', address: "84 Peticle Street", city: "Denver", state: "CO", zipcode: "74529", foster_program: true, rank: 10)

    @pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald')
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster')
    @pet_3 = Pet.create(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle')

    @dean = Application.create!(applicant_name: "Dean Dumdun",
                                applicant_street_address: "123 Main Street",
                                applicant_city: "Denver",
                                applicant_state: "CO",
                                applicant_zipcode: "56789",
                                description: "I already have a dog and would love for him to have friends",
                                status: "In Progress")

  end

  it 'lists all the pets with their attributes' do
    visit "/pets"

    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_1.breed)
    expect(page).to have_content(@pet_1.age)
    expect(page).to have_content(@shelter_1.name)

    expect(page).to have_content(@pet_2.name)
    expect(page).to have_content(@pet_2.breed)
    expect(page).to have_content(@pet_2.age)
    expect(page).to have_content(@shelter_2.name)
  end

  it 'only lists adoptable pets' do
    visit "/pets"

    expect(page).to have_content(@pet_1)
    expect(page).to have_content(@pet_2)
    # expect(page).to have_no_content(pet_3.name)
  end

  it 'displays a link to edit each pet' do
    visit '/pets'

    expect(page).to have_button("Edit")

    click_link("Edit")

    expect(page).to have_current_path("/pets/#{@pet_1.id}/edit")
  end

  it 'displays a link to delete each pet' do
    visit '/pets'

    expect(page).to have_content("Delete")
    expect(page).to have_content("Delete")

    click_link "Delete"

    expect(page).to have_current_path("/pets")
    expect(page).to_not have_content(@pet_1.name)
  end

  it 'has a text box to filter results by keyword' do
    visit "/pets"

    expect(page).to have_button("Search")
  end

  xit 'lists partial matches as search results' do
    visit "/pets"

    fill_in 'Search', with: "Ba"
    click_on "Search", match: :all

    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_2.name)
    expect(page).to_not have_content(@pet_3.name)
  end

  describe "Start an Application" do
    it "has a link to start an application" do
      visit "/pets"

      click_on "Start an Application", match: :first

      expect(current_path).to eq("/applications/new")
      expect(page).to have_field("Name")
      expect(page).to have_field("Street Address")
      expect(page).to have_field("City")
      expect(page).to have_field("State")
      expect(page).to have_field("Zipcode")
      # expect(page).to have_field("Description")
      # expect(page).to have_field("Status")
    end

    it "allows applicant to fill out the application and submit" do
      visit "/applications/new"

      fill_in "Name", with: "Dean Durham"
      fill_in "Street Address", with: "123 Main Street"
      fill_in "City", with: "Denver"
      fill_in "State", with: "CO"
      fill_in "Zipcode", with: "89768"
      # fill_in "Description", with: "I would love for my dog to have friends"
      # fill_in "Status", with: "In Progress"

      click_button "Submit", match: :first

      expect(current_path).to eq("/applications/#{Application.last.id}")
    end
  end

end

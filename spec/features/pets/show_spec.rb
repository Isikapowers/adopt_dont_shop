require 'rails_helper'

RSpec.describe 'the shelter show' do
  it "shows the shelter and all it's attributes" do
    shelter_1 = Shelter.create(name: 'Aurora shelter', address: "2345 Main Street", city: "Aurora", state: "CO", zipcode: "46352", foster_program: false, rank: 9)
    shelter_2 = Shelter.create(name: 'RGV animal shelter', address: "4573 South Street", city: "Harlingen", state: "TX", zipcode: "57253", foster_program: false, rank: 5)
    shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', address: "84 Peticle Street", city: "Denver", state: "CO", zipcode: "74529", foster_program: true, rank: 10)

    pet = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)

    visit "/pets/#{pet.id}"

    expect(page).to have_content(pet.name)
    expect(page).to have_content(pet.age)
    expect(page).to have_content(pet.adoptable)
    expect(page).to have_content(pet.breed)
    expect(page).to have_content(pet.shelter_name)
  end

  it "allows the user to delete a pet" do
    shelter_1 = Shelter.create(name: 'Aurora shelter', address: "2345 Main Street", city: "Aurora", state: "CO", zipcode: "46352", foster_program: false, rank: 9)
    shelter_2 = Shelter.create(name: 'RGV animal shelter', address: "4573 South Street", city: "Harlingen", state: "TX", zipcode: "57253", foster_program: false, rank: 5)
    shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', address: "84 Peticle Street", city: "Denver", state: "CO", zipcode: "74529", foster_program: true, rank: 10)

    pet = Pet.create(name: 'Scrappy', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)

    visit "/pets/#{pet.id}"

    click_on "Delete"

    expect(page).to have_current_path('/pets')
    expect(page).to_not have_content(pet.name)
  end
end

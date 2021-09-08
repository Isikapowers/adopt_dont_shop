# require 'rails_helper'
#
# RSpec.describe 'the Pet Show Page' do
#   it "shows the shelter and all it's attributes" do
#     shelter = Shelter.create(name: 'Aurora shelter', address: "2345 Main Street", city: "Aurora", state: "CO", zipcode: "46352", foster_program: false, rank: 9)
#     shelter_2 = Shelter.create(name: 'RGV animal shelter', address: "4573 South Street", city: "Harlingen", state: "TX", zipcode: "57253", foster_program: false, rank: 5)
#     shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', address: "84 Peticle Street", city: "Denver", state: "CO", zipcode: "74529", foster_program: true, rank: 10)
#
#     pet = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true)
#
#     visit "/pets"
#
#     # expect(page).to have_content('Scooby')
#     # expect(page).to have_content("Age: 2")
#     expect(page).to have_content("true")
#     expect(page).to have_content('Great Dane')
#     expect(page).to have_content(pet.shelter_name)
#   end
#
#   it "allows the user to delete a pet" do
#     shelter = Shelter.create(name: 'Aurora shelter', address: "2345 Main Street", city: "Aurora", state: "CO", zipcode: "46352", foster_program: false, rank: 9)
#     shelter_2 = Shelter.create(name: 'RGV animal shelter', address: "4573 South Street", city: "Harlingen", state: "TX", zipcode: "57253", foster_program: false, rank: 5)
#     shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', address: "84 Peticle Street", city: "Denver", state: "CO", zipcode: "74529", foster_program: true, rank: 10)
#
#     pet = Pet.create(name: 'Scrappy', age: 1, breed: 'Great Dane', adoptable: true)
#
#     visit "/pets"
#
#     # click_button "Delete"
#
#     expect(page).to have_current_path('/pets')
#     expect(page).to_not have_content(pet.name)
#   end
# end

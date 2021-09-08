require 'rails_helper'

RSpec.describe 'the shelter show' do
  it "shows the shelter and all it's attributes" do
    shelter = Shelter.create(name: 'Aurora shelter', address: "2345 Main Street", city: "Aurora", state: "CO", zipcode: "46352", foster_program: false, rank: 9)

    visit "/shelters/#{shelter.id}"

    expect(page).to have_content(shelter.name)
    expect(page).to have_content(shelter.rank)
    expect(page).to have_content(shelter.city)
  end

  it "shows the number of pets associated with the shelter" do
    shelter = Shelter.create(name: 'Aurora shelter', address: "2345 Main Street", city: "Aurora", state: "CO", zipcode: "46352", foster_program: false, rank: 9)

    shelter.pets.create(name: 'garfield', breed: 'shorthair', adoptable: true, age: 1)

    visit "/shelters/#{shelter.id}"

    # within ".pet-count" do
    expect(page).to have_content(shelter.pets.count)
    # end
  end

  it "allows the user to delete a shelter" do
    shelter = Shelter.create(name: 'Aurora shelter', address: "2345 Main Street", city: "Aurora", state: "CO", zipcode: "46352", foster_program: false, rank: 9)

    visit "/shelters/#{shelter.id}"

    click_button "Delete #{shelter.name}"

    expect(page).to have_current_path('/shelters')
    expect(page).to_not have_content(shelter.name)
  end

  it 'displays a link to the shelters pets index' do
    shelter = Shelter.create(name: 'Aurora shelter', address: "2345 Main Street", city: "Aurora", state: "CO", zipcode: "46352", foster_program: false, rank: 9)

    visit "/shelters/#{shelter.id}"

    click_button "Check Out Our Pets!"

    expect(page).to have_current_path("/shelters/#{shelter.id}/pets")
  end
end

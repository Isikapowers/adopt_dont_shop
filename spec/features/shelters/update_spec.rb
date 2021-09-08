require 'rails_helper'

RSpec.describe 'the shelter update' do
  it "shows the shelter edit form" do
    shelter = Shelter.create(name: 'Aurora shelter', address: "2345 Main Street", city: "Aurora", state: "CO", zipcode: "46352", foster_program: false, rank: 9)

    visit "/shelters/#{shelter.id}/edit"

    expect(page).to have_field('Name')
    expect(page).to have_field('City')
    expect(page).to have_field('Rank')
    expect(page).to have_field('Foster program')
  end

  context "given valid data" do
    it "submits the edit form and updates the shelter" do
      shelter = Shelter.create(name: 'Aurora shelter', address: "2345 Main Street", city: "Aurora", state: "CO", zipcode: "46352", foster_program: false, rank: 9)

      visit "/shelters/#{shelter.id}/edit"

      fill_in :name, with: 'Wichita Shelter'
      fill_in :address, with: "2345 Main Street"
      fill_in :city, with: 'Wichita'
      fill_in :state, with: "IA"
      fill_in :zipcode, with: "65774"
      uncheck 'Foster program'
      fill_in :rank, with: 10
      click_button 'Save'

      expect(current_path).to eq("/shelters")
      expect(page).to have_content("Wichita Shelter")
      expect(page).to_not have_content('Aurora shelter')
    end
  end

  context "given invalid data" do
    it 're-renders the edit form' do
      shelter = Shelter.create(name: 'Aurora shelter', address: "2345 Main Street", city: "Aurora", state: "CO", zipcode: "46352", foster_program: false, rank: 9)

      visit "/shelters/#{shelter.id}/edit"

      fill_in :name, with: ''
      fill_in :city, with: 'Wichita'
      uncheck 'Foster program'
      click_button 'Save'

      expect(page).to have_content("Error: Name can't be blank")
      expect(page).to have_current_path("/shelters/#{shelter.id}/edit")
    end
  end
end

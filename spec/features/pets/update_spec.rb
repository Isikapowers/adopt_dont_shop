require 'rails_helper'

RSpec.describe 'the pet update' do
  before :each do
    @shelter = Shelter.create(name: 'Aurora shelter', address: "2345 Main Street", city: "Aurora", state: "CO", zipcode: "46352", foster_program: false, rank: 9)
    @pet = @shelter.pets.create!(adoptable: false, age: 3, breed: 'Whippet', name: 'Annabelle')
  end

  it "shows the veterinarian edit form" do

    visit "/pets/#{@pet.id}/edit"

    expect(page).to have_field('Name')
    expect(page).to have_field('Breed')
    expect(page).to have_field('Adoptable')
    expect(page).to have_field('Age')
  end

  context "given valid data" do
    it "submits the edit form and updates the pet" do

      visit "/pets/#{@pet.id}/edit"

      fill_in 'Name', with: 'Itchy'
      uncheck 'Adoptable'
      fill_in 'Age', with: 1
      click_button 'Save'

      expect(page).to have_current_path("/pets/#{@pet.id}")
      expect(page).to have_content('Itchy')
      expect(page).to_not have_content('Charlie')
    end
  end

  context "given invalid data" do
    it 're-renders the edit form' do

      visit "/pets/#{@pet.id}/edit"

      fill_in 'Name', with: ''
      click_button 'Save'

      expect(page).to have_content("Error: Name can't be blank")
      expect(page).to have_current_path("/pets/#{@pet.id}/edit")
    end
  end

end

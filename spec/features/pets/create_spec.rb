require 'rails_helper'

RSpec.describe 'pet creation' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', address: "2345 Main Street", city: "Aurora", state: "CO", zipcode: "46352", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', address: "4573 South Street", city: "Harlingen", state: "TX", zipcode: "57253", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', address: "84 Peticle Street", city: "Denver", state: "CO", zipcode: "74529", foster_program: true, rank: 10)
  end

  describe 'the pet new' do
    it 'renders the new form' do
      visit "/shelters/#{@shelter_1.id}/pets/new"

      expect(page).to have_content('New Pet')
      expect(page).to have_field('Name')
      expect(page).to have_field('Breed')
      expect(page).to have_field('Age')
      expect(page).to have_field('Adoptable')
    end
  end

  describe 'the pet create' do
    context 'given valid data' do
      it 'creates the pet and redirects to the shelter pets index' do
        visit "/shelters/#{@shelter_1.id}/pets/new"

        fill_in 'Name', with: 'Bumblebee'
        fill_in 'Age', with: 1
        fill_in 'Breed', with: 'Welsh Corgi'
        check 'Adoptable'
        click_button 'Save'
        expect(page).to have_current_path("/shelters/#{@shelter_1.id}/pets")
        expect(page).to have_content('Bumblebee')
      end
    end

    context 'given invalid data' do
      it 're-renders the new form' do
        visit "/shelters/#{@shelter_1.id}/pets/new"

        click_button 'Save'
        expect(page).to have_current_path("/shelters/#{@shelter_1.id}/pets/new")
        expect(page).to have_content("Error: Name can't be blank, Age can't be blank, Age is not a number")
      end
    end
  end
end

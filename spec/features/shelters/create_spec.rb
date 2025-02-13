require 'rails_helper'

RSpec.describe 'shelter creation' do
  describe 'the shelter new' do
    it 'renders the new form' do
      visit '/shelters/new'

      expect(page).to have_content('New Shelter')
      expect(page).to have_field('Name')
      expect(page).to have_field('Address')
      expect(page).to have_field('City')
      expect(page).to have_field('State')
      expect(page).to have_field('Zipcode')
      expect(page).to have_field('Rank')
      expect(page).to have_field('Foster program')
    end
  end

  describe 'the shelter create' do
    context 'given valid data' do
      it 'creates the shelter' do
        visit '/shelters/new'

        fill_in :name, with: 'Houston Shelter'
        fill_in :address, with: '123 Main Street'
        fill_in :city, with: 'Houston'
        fill_in :state, with: 'TX'
        fill_in :zipcode, with: '86567'
        check 'Foster program'
        fill_in :rank, with: 7

        click_button 'Save'

        expect(page).to have_current_path('/shelters')
        expect(page).to have_content('Houston Shelter')
      end
    end

    context 'given invalid data' do
      it 're-renders the new form' do
        visit '/shelters/new'
        click_button 'Save'

        fill_in 'City', with: 'Houston'

        expect(page).to have_content("Error: ")
        expect(page).to have_current_path('/shelters/new')
      end
    end
  end
end

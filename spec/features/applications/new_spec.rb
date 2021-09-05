require "rails_helper"

RSpec.describe "Application New Page" do
  describe "Application form" do
    it 'can link to new application from home page' do
      visit '/'

      click_link 'Apply for a Pet!'

      expect(current_path).to eq('/applications/new')
    end

    it 'can link to new applicaiton from pet index page' do
      visit '/pets'

      click_link 'Start an Application', match: :first

      expect(current_path).to eq('/applications/new')
    end

    it 'can fill out a form and create a new application' do
      visit '/applications/new'

      fill_in :application_applicant_name, with: 'Cynthia Brown'
      fill_in :application_applicant_street_address, with: '765 Bee Drive'
      fill_in :application_applicant_city, with: 'Elizabethton'
      fill_in :application_applicant_state, with: 'TN'
      fill_in :application_applicant_zipcode, with: '37644'

      click_button 'Submit'

      expect(page).to have_content('Cynthia Brown')
      expect(page).to have_content('765 Bee Drive')
      expect(page).to have_content('Elizabethton')
      expect(page).to have_content('TN')
      expect(page).to have_content('37644')
      expect(page).to have_content('In Progress')
    end

   it 'can return error message when all fields are not filled in' do
      visit '/applications/new'

      fill_in :application_applicant_name, with: 'Cynthia Brown'
      fill_in :application_applicant_street_address, with: '765 Bee Drive'
      fill_in :application_applicant_city, with: 'Elizabethton'
      fill_in :application_applicant_state, with: 'TN'
      fill_in :application_applicant_zipcode, with: ''

      click_button 'Submit'

      expect(page).to have_current_path('/applications/new')
      expect(page).to have_content("Error: ")
    end
  end
end

require 'rails_helper'

RSpec.describe 'the shelters index' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', address: "2345 Main Street", city: "Aurora", state: "CO", zipcode: "46352", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', address: "4573 South Street", city: "Harlingen", state: "TX", zipcode: "57253", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', address: "84 Peticle Street", city: "Denver", state: "CO", zipcode: "74529", foster_program: true, rank: 10)
    @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
  end

  it 'lists all the shelter names' do
    visit "/shelters"

    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_2.name)
    expect(page).to have_content(@shelter_3.name)
  end

  it 'lists the shelters by most recently created first' do
    visit "/shelters"

    oldest = find("#shelter-#{@shelter_1.id}")
    mid = find("#shelter-#{@shelter_2.id}")
    newest = find("#shelter-#{@shelter_3.id}")

    expect(newest).to appear_before(mid)
    expect(mid).to appear_before(oldest)

  #   within "#shelter-#{@shelter_1.id}" do
  #     expect(page).to have_content("Created at: #{@shelter_1.created_at}")
  #   end
  #
  #   within "#shelter-#{@shelter_2.id}" do
  #     expect(page).to have_content("Created at: #{@shelter_2.created_at}")
  #   end
  #
  #   within "#shelter-#{@shelter_3.id}" do
  #     expect(page).to have_content("Created at: #{@shelter_3.created_at}")
  #   end
  # end
  end

  it 'has a link to sort shelters by the number of pets they have' do
    visit '/shelters'

    expect(page).to have_link("Sort by number of pets")
    click_link("Sort by number of pets")

    expect(page).to have_current_path('/shelters?sort=pet_count')
    expect(@shelter_1.name).to appear_before(@shelter_3.name)
    expect(@shelter_3.name).to appear_before(@shelter_2.name)
  end

  it 'has a link to update each shelter' do
    visit "/shelters"

    expect(page).to have_button("Update")

    click_on "Update", match: :first

    expect(page).to have_current_path("/shelters/#{@shelter_1.id+2}/edit")
  end

  it 'has a link to delete each shelter' do
    visit "/shelters"

    within "#shelter-#{@shelter_1.id}" do
      expect(page).to have_button("Delete")
    end

    within "#shelter-#{@shelter_2.id}" do
      expect(page).to have_button("Delete")
    end

    within "#shelter-#{@shelter_3.id}" do
      expect(page).to have_button("Delete")
    end

    click_on "Delete", match: :first

    expect(page).to have_current_path("/shelters")
    expect(page).to_not have_content(@shelter_1)
  end

  it 'has a text box to filter results by keyword' do
    visit "/shelters"
    expect(page).to have_button("Search")
  end

  it 'lists partial matches as search results' do
    visit "/shelters"

    fill_in :search, with: "RGV"
    click_on "Search", match: :first

    expect(page).to have_content(@shelter_2.name)
    # expect(page).to_not have_content(@shelter_1.name)
  end
end

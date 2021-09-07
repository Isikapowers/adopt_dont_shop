require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe 'relationships' do
    it { should belong_to(:shelter) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:age) }
    it { should validate_numericality_of(:age) }
  end

  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)

    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
  end

  describe 'class methods' do
    describe '#search' do
      it 'returns partial matches' do
        expect(Pet.search("Claw")).to eq([@pet_2])
      end

      it 'returns case insensitive matches' do
        expect(Pet.search("claw")).to eq([@pet_2])
      end
    end

    describe '#adoptable' do
      it 'returns adoptable pets' do
        expect(Pet.adoptable).to eq([@pet_1, @pet_2])
      end
    end
  end

  describe 'instance methods' do
    describe '.shelter_name' do
      it 'returns the shelter name for the given pet' do
        expect(@pet_3.shelter_name).to eq(@shelter_1.name)
      end
    end

    it 'returns pets in alphabetical name order' do
      expect(Pet.alphabetical_pets).to eq([@pet_3.name, @pet_2.name, @pet_1.name])
    end

    it 'can filter pets by age' do
      expect(Pet.shelter_pets_filtered_by_age(4)).to eq([@pet_1])
    end

    it 'can count adoptable pets' do
      expect(@shelter_1.adoptable_pet_count).to eq(2)
    end

    it 'can show all adoptable pets' do
      expect(@shelter_1.adoptable_pets).to eq([@pet_1, @pet_2])
    end

    it "can get average pet age" do
      expect(@shelter_1.pets.average_pet_age).to eq(3)
    end
  end
end

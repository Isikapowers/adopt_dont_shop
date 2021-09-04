class Pet < ApplicationRecord
  
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter

  has_many :pet_applications
  has_many :applications, through: :pet_applications

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def self.search(search)
    where("name iLIKE ?", "%#{search}%")
  end

  def self.alphabetical_pets
    adoptable.order(name: :asc)
  end

  def self.shelter_pets_filtered_by_age(age_filter)
    where('age >= ?', age_filter)
  end

  def adoptable_pet_count
    self.count
  end

  def average_pet_age
    pets.average(:age).to_i
  end
end

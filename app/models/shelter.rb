class Shelter < ApplicationRecord

  validates :name, presence: true
  validates :rank, presence: true, numericality: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true

  has_many :pets, dependent: :destroy
  # has_many :applications, dependent: :destroy
  # has_many :pet_applications, dependent: :destroy

  def self.order_by_recently_created
    order(created_at: :desc)
  end

  def average_pet_age
    pets.average(:age).round
  end

  def self.order_by_name_in_reverse
    # order(name: :desc)
    Shelter.find_by_sql("SELECT * FROM shelters ORDER BY shelters.name DESC")
  end

  def self.order_by_number_of_pets
    select("shelters.*, count(pets.id) AS pets_count")
      .joins("LEFT OUTER JOIN pets ON pets.shelter_id = shelters.id")
      .group("shelters.id")
      .order("pets_count DESC")
  end

  def self.pending_applications
    joins(pets: [:applications]).where("applications.status = ?", "Pending").order(:name).distinct
  end

  def pet_count
    pets.count
  end

  def adoptable_pets
    pets.where(adoptable: true)
  end

  def adoptable_pet_count
    adoptable_pets.count
  end

  def adopted_pet_count
    pets.select("applications.*").joins(:applications).where("applications.status = ?", "Approved").count
  end

  def pets_pending_applications
    pets.joins(:applications).where("applications.status = ?", "Pending").distinct
  end

end

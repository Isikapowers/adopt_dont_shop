class Application < ApplicationRecord

  validates :applicant_name, presence: true
  validates :applicant_street_address, presence: true
  validates :applicant_city, presence: true
  validates :applicant_state, presence: true
  validates :applicant_zipcode, presence: true
  validates :description, presence: true, if: :status_not_in_progress?
  validates :status, presence: true

  has_many :pet_applications
  has_many :pets, through: :pet_applications

  def status_not_in_progress?
    status != "In Progress"
  end

  def self.search_by_name(search)
    where("name iLIKE ?", "%#{search}")
  end

  def self.order_by_id
    order(id: :asc)
  end

end

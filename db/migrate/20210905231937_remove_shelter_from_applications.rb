class RemoveShelterFromApplications < ActiveRecord::Migration[5.2]
  def change
    remove_reference :applications, :shelter, foreign_key: true
  end
end

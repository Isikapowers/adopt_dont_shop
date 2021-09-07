class RemoveSheltersFromApplications < ActiveRecord::Migration[5.2]
  def change
    remove_reference :applications, :shelters, foreign_key: true
  end
end

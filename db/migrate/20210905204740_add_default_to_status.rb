class AddDefaultToStatus < ActiveRecord::Migration[5.2]
  def change
    change_column_default(:pet_applications, :status, 'Pending')
    change_column_default(:applications, :status, 'In Progress')
  end
end

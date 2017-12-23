class AddHoursToReservation < ActiveRecord::Migration[5.1]
  def change
    add_column :reservations, :hours, :integer
  end
end

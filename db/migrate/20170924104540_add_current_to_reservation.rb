class AddCurrentToReservation < ActiveRecord::Migration[5.1]
  def change
    add_column :reservations, :current, :boolean
  end
end

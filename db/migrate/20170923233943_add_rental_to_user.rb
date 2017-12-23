class AddRentalToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :rental, :integer
  end
end

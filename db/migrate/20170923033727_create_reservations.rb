class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.belongs_to :user, index: true
      t.belongs_to :car, index: true
      t.datetime :checkin
      t.datetime :checkout
      t.timestamps
    end
  end
end

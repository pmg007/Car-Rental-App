class CreateCars < ActiveRecord::Migration[5.1]
  def change
    create_table :cars do |t|
      t.string :model
      t.string :manufacturer
      t.string :license
      t.integer :rate
      t.string :location
      t.string :style
      t.string :status

      t.timestamps
    end
  end
end

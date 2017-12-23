class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.belongs_to :user, index: true
      t.belongs_to :car, index: true
      t.boolean :notified

      t.timestamps
    end
  end
end

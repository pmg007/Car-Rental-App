class CreateSuggestions < ActiveRecord::Migration[5.1]
  def change
    create_table :suggestions do |t|
    
      t.belongs_to :user, index: true
      t.string :suggestion
      t.boolean :accepted

      t.timestamps
    end
  end
end

class AddCarParamToSuggestions < ActiveRecord::Migration[5.1]
  def change
    add_column :suggestions, :model, :string
    add_column :suggestions, :manufacturer, :string
    add_column :suggestions, :location, :string
    add_column :suggestions, :style, :string
  end
end

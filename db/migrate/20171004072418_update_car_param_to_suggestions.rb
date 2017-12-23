class UpdateCarParamToSuggestions < ActiveRecord::Migration[5.1]
  def change
    remove_column :suggestions, :manufacturer, :string
    add_column :suggestions, :manufacturer, :string
  end
end

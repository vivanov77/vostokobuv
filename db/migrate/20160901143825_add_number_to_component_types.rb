class AddNumberToComponentTypes < ActiveRecord::Migration[5.0]
  def change
    add_column :component_types, :number, :integer
  end
end
class AddNumberToComponentCategoryTypes < ActiveRecord::Migration[5.0]
  def change
    add_column :component_category_types, :number, :integer
  end
end
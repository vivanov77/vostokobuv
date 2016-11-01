class AddPublicToComponentCategoryTypes < ActiveRecord::Migration[5.0]
  def change
    add_column :component_category_types, :public, :boolean, default: true
  end
end
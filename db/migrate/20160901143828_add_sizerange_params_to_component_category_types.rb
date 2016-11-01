class AddSizerangeParamsToComponentCategoryTypes < ActiveRecord::Migration[5.0]
  def change
    add_column :component_category_types, :has_sizerange, :boolean, default: false
    add_column :component_category_types, :sizerange, :int4range
  end
end
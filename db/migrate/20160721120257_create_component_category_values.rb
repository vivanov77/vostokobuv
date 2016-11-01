class CreateComponentCategoryValues < ActiveRecord::Migration[5.0]
  def change
    create_table :component_category_values do |t|
      t.string :title
      t.belongs_to :component_category_type, index: true

      t.timestamps
    end
  end
end

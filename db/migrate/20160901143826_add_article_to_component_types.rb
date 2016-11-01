class AddArticleToComponentTypes < ActiveRecord::Migration[5.0]
  def change
    add_column :component_types, :atitle, :string
    add_column :component_types, :acontent, :text
    add_column :component_types, :aactive, :boolean, default: false
  end
end
class AddSphinxDeltas < ActiveRecord::Migration[5.0]
  def change	
    add_column :shoes, :delta, :boolean, :default => true, :null => false
    add_column :articles, :delta, :boolean, :default => true, :null => false
    add_column :category_types, :delta, :boolean, :default => true, :null => false
    add_column :category_values, :delta, :boolean, :default => true, :null => false
    add_column :component_category_types, :delta, :boolean, :default => true, :null => false
    add_column :component_category_values, :delta, :boolean, :default => true, :null => false
    add_column :component_subtypes, :delta, :boolean, :default => true, :null => false
    add_column :component_subtypes_components, :delta, :boolean, :default => true, :null => false
    add_column :component_types, :delta, :boolean, :default => true, :null => false                                
    add_column :component_types_components, :delta, :boolean, :default => true, :null => false
    add_column :components, :delta, :boolean, :default => true, :null => false
    add_column :opinions, :delta, :boolean, :default => true, :null => false
    add_column :orders, :delta, :boolean, :default => true, :null => false
    add_column :users, :delta, :boolean, :default => true, :null => false
    add_column :user_news, :delta, :boolean, :default => true, :null => false    
  end
end

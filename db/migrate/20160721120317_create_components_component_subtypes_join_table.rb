class CreateComponentsComponentSubtypesJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_join_table :components, :component_subtypes do |t|
      t.index :component_id    	
      t.index :component_subtype_id
    end
  end
end
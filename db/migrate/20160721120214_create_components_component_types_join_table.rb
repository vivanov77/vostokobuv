class CreateComponentsComponentTypesJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_join_table :components, :component_types do |t|
      t.index :component_id    	
      t.index :component_type_id
    end
  end
end
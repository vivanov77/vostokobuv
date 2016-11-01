class CreateComponentSubtypes < ActiveRecord::Migration[5.0]
  def change
    create_table :component_subtypes do |t|
      t.string :title
      t.belongs_to :component_type, index: true    	

      t.timestamps
    end
  end
end

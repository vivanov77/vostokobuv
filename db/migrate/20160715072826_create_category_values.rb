class CreateCategoryValues < ActiveRecord::Migration[5.0]
  def change
    create_table :category_values do |t|
      t.string :title
      t.belongs_to :category_type, index: true
  	  t.boolean :public, default: false      

      t.timestamps
    end
  end
end

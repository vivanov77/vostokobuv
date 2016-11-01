class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :title
      t.text :content
      t.string :name
      t.string :city
      t.string :email      
      t.string :phone       

      t.timestamps
    end
  end
end

class ChangeUsers2 < ActiveRecord::Migration[5.0]
  def change
   change_table :users do |t|
      t.boolean :admin, default: false
      t.boolean :blocked, default: false

      t.boolean :subscribe_news_shoes, default: false
      t.boolean :subscribe_news_components, default: false      

      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :phone      

      t.string :organization
      t.string :city
      t.string :address

      t.boolean :producer, default: false

      t.string :url_name
      t.string :info
      t.string :contact
      t.string :delivery_info      
      t.string :description

      t.string :phone_organization
	end  
  end
end

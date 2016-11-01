class CreateOrdersUsersJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_join_table :orders, :users do |t|
      t.index :order_id    	
      t.index :user_id
    end
  end
end
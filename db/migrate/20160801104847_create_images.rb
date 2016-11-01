class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.string :file
      t.string :imageable_type
      t.integer :imageable_id

      t.timestamps null: false
    end
  end
end

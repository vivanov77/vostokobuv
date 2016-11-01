class CreateShoes < ActiveRecord::Migration[5.0]
  def change
    create_table :shoes do |t|
      t.string :title
      t.belongs_to :user, index: true
      t.json :categories
      t.string :description

      t.timestamps
    end
  end
end

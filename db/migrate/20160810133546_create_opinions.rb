class CreateOpinions < ActiveRecord::Migration[5.0]
  def change
    create_table :opinions do |t|
      t.text :optext
      t.belongs_to :user, index: true
      t.boolean :active

      t.timestamps
    end
  end
end

class CreateUserNews < ActiveRecord::Migration[5.0]
  def change
    create_table :user_news do |t|
      t.string :title
      t.text :content
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

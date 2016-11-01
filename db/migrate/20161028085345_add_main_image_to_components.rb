class AddMainImageToComponents < ActiveRecord::Migration[5.0]
  def change
    add_column :components, :main_image, :integer, default: 0
  end
end
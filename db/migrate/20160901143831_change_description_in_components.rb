class ChangeDescriptionInComponents < ActiveRecord::Migration[5.0]
  def change
# http://stackoverflow.com/questions/2799774/rails-migration-for-change-column  	
    change_column :components, :description, :text
  end
end
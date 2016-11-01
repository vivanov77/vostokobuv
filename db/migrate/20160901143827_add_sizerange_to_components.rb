class AddSizerangeToComponents < ActiveRecord::Migration[5.0]
  def change
    add_column :components, :sizerange, :int4range
  end
end
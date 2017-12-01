class AddColumnToComment < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :reply, :string
    add_column :comments, :judge, :string
    
  end
end

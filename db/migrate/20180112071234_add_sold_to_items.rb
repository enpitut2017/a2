class AddSoldToItems < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :sold, :integer
    
  end
end

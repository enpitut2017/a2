class AddPassToItems < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :pass, :string
  end
end

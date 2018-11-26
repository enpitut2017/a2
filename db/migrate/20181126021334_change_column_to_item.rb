class ChangeColumnToItem < ActiveRecord::Migration[5.1]
  def change
    change_column :items, :sold, :integer, default: 0
  end
end

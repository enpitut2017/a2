class AddDepartmentToItems < ActiveRecord::Migration[5.1]
  def change
    add_reference :items, :department, foreign_key: true
  end
end

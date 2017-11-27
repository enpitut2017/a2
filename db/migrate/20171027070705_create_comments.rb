class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.integer :item_id
      t.string :comment_body

      t.timestamps
    end
  end
end

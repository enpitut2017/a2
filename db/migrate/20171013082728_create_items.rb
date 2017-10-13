class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :place_id
      t.string :image
      t.integer :price
      t.string :detail
      t.integer :genre_id
      t.integer :student_id
      t.integer :department_id

      t.timestamps
    end
  end
end

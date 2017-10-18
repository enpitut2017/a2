class AddGenresToItems < ActiveRecord::Migration[5.1]
  def change
    add_reference :items, :genre, foreign_key: true
  end
end

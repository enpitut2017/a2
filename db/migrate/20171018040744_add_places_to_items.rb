class AddPlacesToItems < ActiveRecord::Migration[5.1]
  def change
    add_reference :items, :place, foreign_key: true
  end
end

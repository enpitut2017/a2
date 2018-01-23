class CreateTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :tokens do |t|
      t.references :item, null: false     # 商品と紐付け
      t.string :uuid, null: false         # トークン
      t.datetime :expired_at, null: false
      t.timestamps
    end
  end
end

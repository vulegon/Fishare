class CreateCities < ActiveRecord::Migration[7.0]
  def change
    create_table :cities, id: :uuid do |t|
      t.references :prefecture, type: :uuid, null: false, foreign_key: true, comment: '都道府県ID'
      t.string :name, null: false, comment: '市区町村名'
      t.timestamps
    end
  end
end

class CreateFishingSpotLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :fishing_spot_locations, id: :uuid do |t|
      t.references :fishing_spot, null: false, foreign_key: true, type: :uuid, comment: '釣り場ID', on_delete: :cascade
      t.references :prefecture, null: false, foreign_key: true, type: :uuid, comment: '都道府県ID', on_delete: :cascade
      t.decimal :latitude, precision: 10, scale: 8, null: false, comment: '緯度'
      t.decimal :longitude, precision: 11, scale: 8, null: false, comment: '経度'
      t.string :address, null: false, comment: '住所'
      t.timestamps
    end
  end
end

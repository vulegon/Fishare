class CreateFishingSpotLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :fishing_spot_locations, id: :uuid, comment: '釣り場の位置情報'  do |t|
      t.references :fishing_spot, null: false, foreign_key: true, type: :uuid, comment: '釣り場ID', on_delete: :cascade
      t.references :prefecture, null: false, foreign_key: true, type: :uuid, comment: '都道府県ID', on_delete: :cascade
      t.decimal :latitude, precision: 10, scale: 8, null: false, comment: '緯度'
      t.decimal :longitude, precision: 11, scale: 8, null: false, comment: '経度'
      t.string :address, null: false, comment: '住所'
      t.timestamps
    end

    add_index :fishing_spot_locations, %i[latitude longitude], unique: true, name: 'index_fishing_spot_locations_on_latitude_and_longitude_unique'
  end
end

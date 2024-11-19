class CreateFishingSpotFishes < ActiveRecord::Migration[7.0]
  def change
    create_table :fishing_spot_fishes, id: :uuid, comment: '釣り場と魚の紐づけを管理する交差テーブル'  do |t|
      t.references :fishing_spot, null: false, foreign_key: true, type: :uuid, comment: '釣り場ID', on_delete: :cascade
      t.references :fish, null: false, foreign_key: true, type: :uuid, comment: '魚マスタID', on_delete: :cascade
      t.timestamps
    end

    add_index :fishing_spot_fishes, %i[fishing_spot_id fish_id], unique: true, name: 'index_fishing_spot_fishes_on_fishing_spot_id_and_fish_id_unique'
  end
end

class CreateFishingSpotFishes < ActiveRecord::Migration[7.0]
  def change
    create_table :fishing_spot_fishes, id: :uuid do |t|
      t.references :fishing_spot, null: false, foreign_key: true, type: :uuid, comment: '釣り場ID', on_delete: :cascade
      t.references :fish, null: false, foreign_key: true, type: :uuid, comment: '魚ID', on_delete: :cascade
      t.timestamps
    end
  end
end

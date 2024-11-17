class CreateFishingSpots < ActiveRecord::Migration[7.0]
  def change
    create_table :fishing_spots, id: :uuid do |t|
      t.string :name, null: false, comment: '釣り場名'
      t.text :description, null: false, comment: '説明'
      t.timestamps
    end
  end
end

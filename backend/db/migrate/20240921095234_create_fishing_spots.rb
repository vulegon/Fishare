class CreateFishingSpots < ActiveRecord::Migration[7.0]
  def change
    create_table :fishing_spots, id: :uuid do |t|
      t.string :name, null: false
      t.text :description
      t.timestamps
    end
  end
end

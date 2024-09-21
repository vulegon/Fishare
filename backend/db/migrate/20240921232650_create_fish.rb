class CreateFish < ActiveRecord::Migration[7.0]
  def change
    create_table :fish, id: :uuid do |t|
      t.string :name, null: false, comment: '魚の名前'
      t.timestamps
    end
  end
end

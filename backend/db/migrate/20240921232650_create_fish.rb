class CreateFish < ActiveRecord::Migration[7.0]
  def change
    create_table :fish, id: :uuid, comment: '魚のマスタ' do |t|
      t.string :name, null: false, comment: '魚の名前'
      t.integer :display_order, null: false, comment: '表示順'
      t.timestamps
    end

    add_index :fish, :name, unique: true, name: 'index_fish_on_name_unique'
    add_index :fish, :display_order, name: 'index_fish_on_display_order'
  end
end

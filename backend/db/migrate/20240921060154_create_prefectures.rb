class CreatePrefectures < ActiveRecord::Migration[7.0]
  def change
    create_table :prefectures, id: :uuid do |t|
      t.string :name, null: false, comment: '都道府県名'
      t.integer :display_order, null: false, comment: '並び順'

      t.timestamps
    end

    add_index :prefectures, :name, unique: true, name: 'index_prefectures_on_name_unique'
  end
end

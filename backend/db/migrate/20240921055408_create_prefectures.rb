class CreatePrefectures < ActiveRecord::Migration[7.0]
  def change
    create_table :prefectures, id: :uuid do |t|
      t.string :name, null: false, comment: '都道府県名'
      t.integer :sort, null: false, comment: '並び順'
      t.timestamps
    end
  end
end

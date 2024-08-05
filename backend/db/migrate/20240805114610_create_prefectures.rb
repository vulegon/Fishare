class CreatePrefectures < ActiveRecord::Migration[7.0]
  def change
    create_table :prefectures, id: false, comment: '都道府県' do |t|
      t.string :id, null: false, primary_key: true, comment: 'プライマリキー'
      t.string :name, null: false, comment: '都道府県名'

      t.timestamps
    end
  end
end

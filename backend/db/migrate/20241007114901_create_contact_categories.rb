class CreateContactCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :support_contact_categories, id: :uuid, comment: 'お問い合わせの種類マスタ'  do |t|
      t.string :name, null: false, comment: 'カテゴリ名'
      t.string :description, comment: 'カテゴリ説明'
      t.timestamps
    end

    add_index :support_contact_categories, :name, unique: true, name: 'index_support_contact_categories_on_name_unique'
  end
end

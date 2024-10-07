class CreateContactCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :support_contact_categories, id: :uuid do |t|
      t.string :name, null: false, comment: 'カテゴリ名'
      t.string :description, comment: 'カテゴリ説明'
      t.timestamps
    end
  end
end

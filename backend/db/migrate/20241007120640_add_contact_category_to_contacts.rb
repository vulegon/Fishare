class AddContactCategoryToContacts < ActiveRecord::Migration[7.0]
  def change
    add_column :support_contacts, :support_contact_category_id, :uuid, null: false, foreign_key: true, type: :uuid, comment: 'お問い合わせカテゴリID', on_delete: :cascade
  end
end

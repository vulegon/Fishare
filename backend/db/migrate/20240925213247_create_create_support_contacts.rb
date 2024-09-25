class CreateCreateSupportContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :create_support_contacts, id: :uuid do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.text :content, null: false
      t.timestamps
    end
  end
end

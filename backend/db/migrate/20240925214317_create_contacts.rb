class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :support_contacts, id: :uuid, comment: 'お問い合わせ内容'  do |t|
      t.string :name, null: false, comment: 'お問い合わせ者の名前'
      t.string :email, null: false, comment: 'お問い合わせ者のメールアドレス'
      t.text :content, null: false, comment: 'お問い合わせ内容'
      t.timestamps
    end
  end
end

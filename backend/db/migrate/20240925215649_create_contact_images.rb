class CreateContactImages < ActiveRecord::Migration[7.0]
  def change
    create_table :support_contact_images, id: :uuid, comment: 'お問い合わせの画像'  do |t|
      t.references :support_contact, null: false, foreign_key: true, type: :uuid, comment: 'お問い合わせID', on_delete: :cascade
      t.string :s3_key, null: false, comment: 'S3キー'
      t.string :file_name, null: false, comment: 'ファイル名'
      t.string :content_type, null: false, comment: 'ファイルの拡張子'
      t.integer :file_size, null: false, comment: 'ファイルサイズ'
      t.integer :display_order, null: false, comment: '表示順'
      t.timestamps
    end

    add_index :support_contact_images, %i[s3_key], unique: true, name: 'index_support_contact_images_on_s3_key_unique'
    add_index :support_contact_images, %i[support_contact_id display_order], unique: true, name: 'index_support_contact_images_on_contact_id_and_display_order'
  end
end

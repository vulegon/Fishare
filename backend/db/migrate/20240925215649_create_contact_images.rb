class CreateContactImages < ActiveRecord::Migration[7.0]
  def change
    create_table :support_contact_images, id: :uuid do |t|
      t.references :support_contact, null: false, foreign_key: true, type: :uuid, comment: 'お問い合わせID', on_delete: :cascade
      t.string :s3_key, null: false, comment: 'S3キー'
      t.string :s3_url, null: false, comment: 'S3のURL'
      t.string :file_name, null: false, comment: 'ファイル名'
      t.string :content_type, null: false, comment: 'ファイルの拡張子'
      t.integer :file_size, null: false, comment: 'ファイルサイズ'
      t.timestamps
    end
  end
end

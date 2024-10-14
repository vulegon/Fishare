class CreateFishingSpotImages < ActiveRecord::Migration[7.0]
  def change
    create_table :fishing_spot_images, id: :uuid do |t|
      t.references :fishing_spot, null: false, foreign_key: true, type: :uuid, comment: '釣り場ID'
      t.string :s3_key, null: false, comment: 'S3キー'
      t.string :s3_url, null: false, comment: 'S3のURL'
      t.string :file_name, null: false, comment: 'ファイル名'
      t.string :content_type, null: false, comment: 'ファイルの拡張子'
      t.integer :file_size, null: false, comment: 'ファイルサイズ'
      t.timestamps
    end
  end
end

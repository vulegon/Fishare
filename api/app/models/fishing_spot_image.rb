# == Schema Information
#
# Table name: fishing_spot_images
#
#  id                             :uuid             not null, primary key
#  content_type(ファイルの拡張子) :string           not null
#  display_order(表示順)          :integer          not null
#  file_name(ファイル名)          :string           not null
#  file_size(ファイルサイズ)      :integer          not null
#  s3_key(S3キー)                 :string           not null
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  fishing_spot_id(釣り場ID)      :uuid             not null
#
# Indexes
#
#  index_fishing_spot_images_on_fishing_spot_id                   (fishing_spot_id)
#  index_fishing_spot_images_on_s3_key_unique                     (s3_key) UNIQUE
#  index_fishing_spot_images_on_spot_id_and_display_order_unique  (fishing_spot_id,display_order) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (fishing_spot_id => fishing_spots.id)
#

# 釣り場の画像を管理するモデル
class FishingSpotImage < ApplicationRecord
  audited
  belongs_to :fishing_spot

  validates :s3_key, presence: true, uniqueness: true
  validates :file_name, presence: true
  validates :content_type, presence: true
  validates :file_size, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :display_order, presence: true, uniqueness: { scope: :fishing_spot_id }, numericality: { greater_than_or_equal_to: 0 }

  scope :order_by_display_order, -> { order(display_order: :asc) }

  # 画像を閲覧する用のPresigned URLを取得する
  def presigned_url
    s3_helper = LibAws::S3Helper.new
    s3_helper.get_presigned_url(
      bucket_name: Rails.configuration.x.lib_aws.s3[:fishing_spot_image_bucket],
      key: self.s3_key
    )
  end
end

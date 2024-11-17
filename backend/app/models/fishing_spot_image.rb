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
#  index_fishing_spot_images_on_fishing_spot_id  (fishing_spot_id)
#  index_fishing_spot_images_on_s3_key_unique    (s3_key) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (fishing_spot_id => fishing_spots.id)
#

# 釣り場の画像を管理するモデル
class FishingSpotImage < ApplicationRecord
  audited
  belongs_to :fishing_spot

  validates :content_type, :display_order, :file_name, :file_size, :s3_key, presence: true
end

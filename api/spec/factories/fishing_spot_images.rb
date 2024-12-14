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
FactoryBot.define do
  factory :fishing_spot_image do
    association :fishing_spot
    s3_key { "fishing_spots/#{SecureRandom.uuid}" }
    file_name { Faker::File.file_name(dir: '', ext: 'jpg').delete_prefix("/") }
    content_type { 'image/jpeg' }
    file_size { 1024 }
    display_order { 0 }
  end
end

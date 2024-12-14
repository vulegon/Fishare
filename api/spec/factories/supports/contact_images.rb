# == Schema Information
#
# Table name: support_contact_images
#
#  id                                 :uuid             not null, primary key
#  content_type(ファイルの拡張子)     :string           not null
#  display_order(表示順)              :integer          not null
#  file_name(ファイル名)              :string           not null
#  file_size(ファイルサイズ)          :integer          not null
#  s3_key(S3キー)                     :string           not null
#  created_at                         :datetime         not null
#  updated_at                         :datetime         not null
#  support_contact_id(お問い合わせID) :uuid             not null
#
# Indexes
#
#  index_support_contact_images_on_contact_id_and_display_order  (support_contact_id,display_order) UNIQUE
#  index_support_contact_images_on_s3_key_unique                 (s3_key) UNIQUE
#  index_support_contact_images_on_support_contact_id            (support_contact_id)
#
# Foreign Keys
#
#  fk_rails_...  (support_contact_id => support_contacts.id)
#
FactoryBot.define do
  factory :support_contact_image, class: 'Supports::ContactImage' do
    association :support_contact
    s3_key { "s3_key/contact_image.jpg" }
    file_name { "contact_image.jpg" }
    content_type { "image/jpg" }
    file_size { 1024 }
  end
end

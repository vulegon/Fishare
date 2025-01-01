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

# お問い合わせ画像
module Supports
  class ContactImage < ApplicationRecord
    self.table_name = 'support_contact_images'
    audited

    belongs_to :contact, class_name: 'Supports::Contact', foreign_key: :support_contact_id, inverse_of: :images

    validates :s3_key, presence: true, uniqueness: true
    validates :file_name, presence: true
    validates :content_type, presence: true
    validates :file_size, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :display_order, presence: true, uniqueness: { scope: :support_contact_id }, numericality: { greater_than_or_equal_to: 0 }

    # 画像を閲覧する用のPresigned URLを取得する
    def presigned_url
      s3_helper = LibAws::S3Helper.new
      s3_helper.get_presigned_url(
        bucket_name: Rails.configuration.x.lib_aws.s3[:support_contact_image_bucket],
        key: self.s3_key
      )
    end
  end
end

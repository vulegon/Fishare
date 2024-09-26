# == Schema Information
#
# Table name: support_contact_images
#
#  id                                 :uuid             not null, primary key
#  content_type(ファイルの拡張子)     :string           not null
#  file_name(ファイル名)              :string           not null
#  file_size(ファイルサイズ)          :integer          not null
#  s3_key(S3キー)                     :string           not null
#  s3_url(S3のURL)                    :string           not null
#  created_at                         :datetime         not null
#  updated_at                         :datetime         not null
#  support_contact_id(お問い合わせID) :uuid             not null
#
# Indexes
#
#  index_support_contact_images_on_support_contact_id  (support_contact_id)
#
# Foreign Keys
#
#  fk_rails_...  (support_contact_id => support_contacts.id)
#
module Supports
  class ContactImage < ApplicationRecord
    self.table_name = 'support_contact_images'
    audited

    belongs_to :contact, class_name: 'Supports::Contact', foreign_key: :contact_id, inverse_of: :images
  end
end

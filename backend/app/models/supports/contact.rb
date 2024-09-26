# == Schema Information
#
# Table name: support_contacts
#
#  id         :uuid             not null, primary key
#  content    :text             not null
#  email      :string           not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
module Supports
  class Contact < ApplicationRecord
    self.table_name = 'support_contacts'
    audited

    has_many :images, class_name: 'Supports::ContactImage', dependent: :destroy, foreign_key: :contact_id, inverse_of: :contact

    validates :name, :email, :contact_content, presence: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  end
end

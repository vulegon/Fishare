# == Schema Information
#
# Table name: support_contacts
#
#  id                                                  :uuid             not null, primary key
#  content(お問い合わせ内容)                           :text             not null
#  email(お問い合わせ者のメールアドレス)               :string           not null
#  name(お問い合わせ者の名前)                          :string           not null
#  created_at                                          :datetime         not null
#  updated_at                                          :datetime         not null
#  support_contact_category_id(お問い合わせカテゴリID) :uuid             not null
#
module Supports
  class Contact < ApplicationRecord
    self.table_name = 'support_contacts'
    audited

    has_many :images, class_name: 'Supports::ContactImage', dependent: :destroy, foreign_key: :support_contact_id, inverse_of: :contact
    belongs_to :category, class_name: 'Supports::ContactCategory', foreign_key: :support_contact_category_id, inverse_of: :contacts

    validates :name, :email, :content, presence: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  end
end

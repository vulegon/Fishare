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
require 'rails_helper'

RSpec.describe ::Supports::Contact, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

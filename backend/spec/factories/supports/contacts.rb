# == Schema Information
#
# Table name: support_contacts
#
#  id                                      :uuid             not null, primary key
#  content                                 :text             not null
#  email                                   :string           not null
#  name                                    :string           not null
#  created_at                              :datetime         not null
#  updated_at                              :datetime         not null
#  support_contact_category_id(カテゴリID) :uuid             not null
#
FactoryBot.define do
  factory :support_contact, class: 'Supports::Contact' do
    name { "テスト 太郎" }
    email { "contact@test.com" }
    content { "お問い合わせ内容サンプル" }
    support_contact_category_id { ::Supports::ContactCategory.pluck(:id).sample }
  end
end

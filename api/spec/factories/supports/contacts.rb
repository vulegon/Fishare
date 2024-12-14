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
FactoryBot.define do
  factory :support_contact, class: 'Supports::Contact' do
    association :support_contact_category
    name { "テスト 太郎" }
    email { "contact@test.com" }
    content { "お問い合わせ内容サンプル" }
  end
end

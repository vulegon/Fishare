FactoryBot.define do
  factory :support_contact, class: 'Supports::Contact' do
    name { "テスト 太郎" }
    email { "contact@test.com" }
    content { "お問い合わせ内容サンプル" }
  end
end

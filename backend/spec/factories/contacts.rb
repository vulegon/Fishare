FactoryBot.define do
  factory :contact do
    name { "テスト 太郎" }
    email { "contact@test.com" }
    content { "お問い合わせ内容サンプル" }
  end
end

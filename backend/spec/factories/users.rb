# == Schema Information
#
# Table name: users
#
#  id                       :uuid             not null, primary key
#  allow_password_change    :boolean          default(FALSE)
#  confirmation_sent_at     :datetime
#  confirmation_token       :string
#  confirmed_at             :datetime
#  email(メールアドレス)    :string           not null
#  encrypted_password       :string           default(""), not null
#  failed_attempts          :integer          default(0), not null
#  locked_at                :datetime
#  name(名前)               :string           not null
#  provider                 :string           default("email"), not null
#  remember_created_at      :datetime
#  reset_password_sent_at   :datetime
#  reset_password_token     :string
#  tokens                   :json
#  uid                      :string           default(""), not null
#  unconfirmed_email        :string
#  unlock_token             :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid_and_provider      (uid,provider) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#
FactoryBot.define do
  factory :user do
    name { "Test User" }
    email { "test@example.com" }
    password { "password123" }
    password_confirmation { "password123" }
    confirmed_at { Time.now }

    trait :admin do
      after(:create) do |user|
        user.user_roleships.create(user_role: UserRole.find_or_create_by(role: :admin))
      end
    end
  end
end

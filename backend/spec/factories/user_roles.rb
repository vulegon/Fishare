# == Schema Information
#
# Table name: user_roles
#
#  id           :uuid             not null, primary key
#  role(権限)   :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_user_roles_on_role_unique  (role) UNIQUE
#
FactoryBot.define do
  factory :user_role do
    role { 0 }
  end
end

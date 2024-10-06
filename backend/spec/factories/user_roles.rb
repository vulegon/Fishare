# == Schema Information
#
# Table name: user_roles
#
#  id           :uuid             not null, primary key
#  role(権限)   :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
FactoryBot.define do
  factory :user_role do
    role { 0 }
  end
end

# == Schema Information
#
# Table name: user_roleships
#
#  id                           :uuid             not null, primary key
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  user_id(ユーザーID)          :uuid             not null
#  user_role_id(ユーザー権限ID) :uuid             not null
#
# Indexes
#
#  index_user_roleships_on_user_id                          (user_id)
#  index_user_roleships_on_user_id_and_user_role_id_unique  (user_id,user_role_id) UNIQUE
#  index_user_roleships_on_user_role_id                     (user_role_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#  fk_rails_...  (user_role_id => user_roles.id)
#
FactoryBot.define do
  factory :user_roleship do
    association :user
    association :user_role
  end
end

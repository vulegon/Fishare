# == Schema Information
#
# Table name: fish
#
#  id             :uuid             not null, primary key
#  name(魚の名前) :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_fish_on_name_unique  (name) UNIQUE
#
FactoryBot.define do
  factory :fish do
    name { "テスト魚1" }
  end
end

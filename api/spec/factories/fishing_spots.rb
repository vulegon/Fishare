# == Schema Information
#
# Table name: fishing_spots
#
#  id                :uuid             not null, primary key
#  description(説明) :text             not null
#  name(釣り場名)    :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
FactoryBot.define do
  factory :fishing_spot do
    name { "テスト釣り場1" }
    description { "テスト説明1" }
  end
end

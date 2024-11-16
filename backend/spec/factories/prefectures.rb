# == Schema Information
#
# Table name: prefectures
#
#  id                    :uuid             not null, primary key
#  display_order(並び順) :integer          not null
#  name(都道府県名)      :string           not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
FactoryBot.define do
  factory :prefecture do
    name { "東京都" }
    display_order { 0 }
  end
end

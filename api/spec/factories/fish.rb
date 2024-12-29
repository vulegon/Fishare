# == Schema Information
#
# Table name: fish
#
#  id                    :uuid             not null, primary key
#  display_order(表示順) :integer          not null
#  name(魚の名前)        :string           not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
# Indexes
#
#  index_fish_on_display_order  (display_order)
#  index_fish_on_name_unique    (name) UNIQUE
#
FactoryBot.define do
  factory :fish do
    name { "テスト魚1" }
    display_order { 1 }
  end
end

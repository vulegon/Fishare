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

# 魚のマスタを管理するモデル
class Fish < ApplicationRecord
  audited
  has_many :fishing_spot_fishes
  has_many :fishing_spots, through: :fishing_spot_fishes

  validates :name, presence: true, uniqueness: true
end

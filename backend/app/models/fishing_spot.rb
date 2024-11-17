# == Schema Information
#
# Table name: fishing_spots
#
#  id          :uuid             not null, primary key
#  description :text
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# 釣り場を表すテーブル
class FishingSpot < ApplicationRecord
  has_many :fishing_spot_fishes, dependent: :destroy, inverse_of: :fishing_spot
  has_many :fishes, through: :fishing_spot_fishes
  has_many :locations, class_name: 'FishingSpotLocation', dependent: :destroy, inverse_of: :fishing_spot
  has_many :images, class_name: 'FishingSpotImage', dependent: :destroy, inverse_of: :fishing_spot
end

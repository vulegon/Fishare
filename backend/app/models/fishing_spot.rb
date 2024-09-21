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
class FishingSpot < ApplicationRecord
  has_many :fishing_spot_fishes
  has_many :fishes, through: :fishing_spot_fishes
end

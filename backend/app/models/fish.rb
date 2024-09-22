# == Schema Information
#
# Table name: fish
#
#  id             :uuid             not null, primary key
#  name(魚の名前) :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Fish < ApplicationRecord
  has_many :fishing_spot_fishes
  has_many :fishing_spots, through: :fishing_spot_fishes
end

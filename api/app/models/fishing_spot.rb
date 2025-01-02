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

# 釣り場を管理するモデル
class FishingSpot < ApplicationRecord
  audited
  has_many :fishing_spot_fishes, dependent: :destroy, inverse_of: :fishing_spot
  has_many :fishes, through: :fishing_spot_fishes
  has_many :locations, class_name: 'FishingSpotLocation', dependent: :destroy, inverse_of: :fishing_spot
  has_many :images, class_name: 'FishingSpotImage', dependent: :destroy, inverse_of: :fishing_spot

  has_many :display_order_images, -> { order_by_display_order }, class_name: 'FishingSpotImage', inverse_of: :fishing_spot

  validates :description, :name, presence: true

  scope :name_like, ->(name) { where('name ILIKE ?', "%#{ActiveRecord::Base.sanitize_sql_like(name)}%") }
end

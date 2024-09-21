class FishingSpotFish < ApplicationRecord
  belongs_to :fishing_spot
  belongs_to :fish
end

class FishingSpotLocationRepository
  class << self
    def save!(entity)
      entity.save!
    end
  end
end

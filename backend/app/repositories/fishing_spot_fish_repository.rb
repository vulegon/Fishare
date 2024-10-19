class FishingSpotFishRepository
  class << self
    def save_all!(entity)
      entity.each(&:save!)
    end
  end
end

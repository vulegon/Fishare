class FishingSpotRepository
  class << self
    # 釣り場を永続化する
    # @param fishing_spot [FishingSpot] 永続化する釣り場
    # @return [FishingSpot] 永続化された釣り場
    def save!(fishing_spot)
      fishing_spot.save!
    end
  end
end

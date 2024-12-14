class FishingSpotFishFactory
  def build(fish_id, fishing_spot_id)
    fishing_spot_fish_id = SecureRandom.uuid
    ::FishingSpotFish.new(
      id: fishing_spot_fish_id,
      fishing_spot_id: fishing_spot_id,
      fish_id: fish_id,
    )
  end

  def build_all(fish_ids, fishing_spot_id)
    fish_ids.map do |fish_id|
      build(fish_id, fishing_spot_id)
    end
  end
end


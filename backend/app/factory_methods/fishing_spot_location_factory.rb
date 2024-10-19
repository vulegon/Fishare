class FishingSpotLocationFactory
  def build(fish_id, fishing_spot_id)
    fishing_spot_fish_id = SecureRandom.uuid
    ::FishingSpotImage.new(
      id: fishing_spot_fish_id,
      fishing_spot_id: fishing_spot_id,
      fish_id: fish_id,
    )
  end
end


class FishingSpotLocationFactory
  def build(params, fishing_spot_id)
    fishing_spot_location_id = SecureRandom.uuid
    ::FishingSpotLocation.new(
      id: fishing_spot_location_id,
      fishing_spot_id: fishing_spot_id,
      prefecture_id: params.prefecture.id,
      latitude: params.location[:latitude],
      longitude: params.location[:longitude],
      address: params.location[:address]
    )
  end
end


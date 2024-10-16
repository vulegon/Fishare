class FishingSpotFactory
  def build(params)
    FishingSpot.new(
      id: SecureRandom.uuid,
      name: params.name,
      description: params.description,
    )
  end
end

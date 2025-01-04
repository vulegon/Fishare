module FishingSpots
  class UpdateDomainService
    class << self
      def update(update_params)
        fishing_spot = update_params.fishing_spot

        fishing_spot.assign_attributes(
          name: update_params.name,
          description: update_params.description,
        )

        fishing_spot
      end
    end
  end
end

module FishingSpotImages
  class UpdateDomainService
    class << self
      def update(update_params)
        fishing_spot_images = update_params.fishing_spot.images
      end
    end
  end
end

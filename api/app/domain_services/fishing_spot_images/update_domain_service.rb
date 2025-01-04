module FishingSpotImages
  class UpdateDomainService
    class << self
      def update(update_params)
        before_image_ids = update_params.fishing_spot.images.pluck(:id)
        after_image_ids = update_params.image_forms
      end
    end
  end
end

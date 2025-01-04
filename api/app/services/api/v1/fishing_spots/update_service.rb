module Api
  module V1
    module FishingSpots
      class UpdateService
        class << self
          def update!(update_params)
            updated_fishing_spot = ::FishingSpots::UpdateDomainService.update(update_params)
            updated_fishing_spot_images = ::FishingSpotImages::UpdateDomainService.update_images(fishing_spot, update_params.image_forms)
            fishing_spot_fishes = ::FishingSpotFishes::UpdateDomainService.update_fishes(fishing_spot, update_params.fishes.pluck(:id))
            fishing_spot_location = ::FishingSpotLocationFactory.new.update(fishing_spot.fishing_spot_location, update_params)

            ActiveRecord::Base.transaction do
              FishingSpotRepository.save!(fishing_spot)
              FishingSpotImageRepository.save_all!(fishing_spot_images)
              FishingSpotFishRepository.save_all!(fishing_spot_fishes)
              FishingSpotLocationRepository.save!(fishing_spot_location)
            end
          end
        end
      end
    end
  end
end

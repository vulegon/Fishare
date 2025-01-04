module Api
  module V1
    module FishingSpots
      class UpdateService
        class << self
          def update!(update_params)
            updated_fishing_spot = ::FishingSpots::UpdateDomainService.update(update_params)
            updated_fishing_spot_images = ::FishingSpotImages::UpdateDomainService.update_images(update_params)
            fishing_spot_fishes = ::FishingSpotFishes::UpdateDomainService.update_fishes(update_params)
            fishing_spot_location = ::FishingSpotLocationFactory.new.update(update_params)

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

module Api
  module V1
    module FishingSpots
      class CreateService
        class << self
          # 釣り場を作成する
          # @param params [Api::V1::FishingSpots::CreateParameter]
          # @return [FishingSpot] 永続化された釣り場
          def create!(params)
            fishing_spot = ::FishingSpotFactory.new.build(params)
            fishing_spot_images = ::FishingSpotImageFactory.new.build_all(params.image_forms, fishing_spot.id)
            fishing_spot_fishes = ::FishingSpotFishFactory.new.build_all(params.fishes.pluck(:id), fishing_spot.id)
            fishing_spot_location = ::FishingSpotLocationFactory.new.build(params, fishing_spot.id)

            ActiveRecord::Base.transaction do
              FishingSpotRepository.save!(fishing_spot)
              FishingSpotImageRepository.save_all!(fishing_spot_images)
              FishingSpotFishRepository.save_all!(fishing_spot_fishes)
              FishingSpotLocationRepository.save!(fishing_spot_location)
            end

            fishing_spot.reload
          end
        end
      end
    end
  end
end

module Api
  module V1
    module FishingSpots
      module Show
        class FishingSpotSerializer < ActiveModel::Serializer
          attributes :id, :name, :description, :prefecture_name, :latitude, :longitude, :address, :images, :fishes

          def initialize(object, options = {})
            super
            @fishing_spot_location = options[:fishing_spot_location]
          end

          def prefecture_name
            @fishing_spot_location.prefecture.name
          end

          def latitude
            @fishing_spot_location.latitude
          end

          def longitude
            @fishing_spot_location.longitude
          end

          def address
            @fishing_spot_location.address
          end

          def fishes
            object.fishes.map do |fish|
              FishingSpotFishSerializer.new(fish).as_json
            end
          end

          def images
            object.images.order(display_order: :asc).map do |image|
              FishingSpotImageSerializer.new(image).as_json
            end
          end
        end
      end
    end
  end
end

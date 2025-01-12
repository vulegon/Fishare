module Api
  module V1
    module FishingSpots
      module Index
        class FishingSpotSerializer < ActiveModel::Serializer
          attributes :id, :name, :description, :fishes, :location, :images

          def fishes
            object.fishing_spot_fishes.map do |fishing_spot_fish|
              { id: fishing_spot_fish.fish.id, name: fishing_spot_fish.fish.name }
            end
          end

          def location
            location = object.location
            {
              id: location.id,
              address: location.address,
              prefecture: {
                id: location.prefecture.id,
                name: location.prefecture.name
              },
              latitude: location.latitude,
              longitude: location.longitude
            }
          end

          def images
            object.display_order_images.map do |image|
              {
                id: image.id,
                s3_key: image.s3_key,
                file_name: image.file_name,
                content_type: image.content_type,
                file_size: image.file_size,
                display_order: image.display_order,
                presigned_url: image.presigned_url
              }
            end
          end
        end
      end
    end
  end
end

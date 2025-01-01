module Api
  module V1
    module FishingSpots
      module Index
        class FishingSpotSerializer < ActiveModel::Serializer
          attributes :id, :name, :description, :fishes, :locations, :images

          def fishes
            object.fishing_spot_fishes.map do |fishing_spot_fish|
              { id: fishing_spot_fish.fish.id, name: fishing_spot_fish.fish.name }
            end
          end

          def locations
            object.locations.map do |location|
              {
                prefecture: {
                  id: location.prefecture.id,
                  name: location.prefecture.name
                }
              }
            end
          end

          def images
            object.images.map do |image|
              {
                id: image.id,
                file_name: image.file_name,
                content_type: image.content_type,
                file_size: image.file_size,
                s3_key: image.s3_key,
                presigned_url: image.presigned_url
              }
            end
          end
        end
      end
    end
  end
end

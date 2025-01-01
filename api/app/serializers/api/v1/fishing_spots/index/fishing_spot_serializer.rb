module Api
  module V1
    module FishingSpots
      module Index
        class FishingSpotSerializer < ActiveModel::Serializer
          attributes :id, :name, :description, :fishes, :locations

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
        end
      end
    end
  end
end

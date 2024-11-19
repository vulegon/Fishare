module Api
  module V1
    module FishingSpots
      module Show
        class FishingSpotFishSerializer < ActiveModel::Serializer
          attributes :id, :name
        end
      end
    end
  end
end

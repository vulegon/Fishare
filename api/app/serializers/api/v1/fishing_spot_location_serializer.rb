module Api
  module V1
    class FishingSpotLocationSerializer < ActiveModel::Serializer
      attributes :id, :fishing_spot_id, :prefecture_id, :latitude, :longitude, :address
    end
  end
end

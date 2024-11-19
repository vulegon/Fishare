module Api
  module V1
    module FishingSpots
      module Show
        class FishingSpotImageSerializer < ActiveModel::Serializer
          attributes :id, :s3_key, :file_name, :content_type, :display_order
        end
      end
    end
  end
end

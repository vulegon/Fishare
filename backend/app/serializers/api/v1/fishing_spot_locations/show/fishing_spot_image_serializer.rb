module Api
  module V1
    module FishingSpotLocations
      module Show
        class FishingSpotImageSerializer < ActiveModel::Serializer
          attributes :id, :s3_key, :file_name, :content_type
        end
      end
    end
  end
end

module Api
  module V1
    class FishingSpotLocationsController < ApplicationController
      def index
        fishing_spot_locations = FishingSpotLocation.all
        serialized_fishing_spot_locations = ActiveModelSerializers::SerializableResource.new(
          fishing_spot_locations,
          each_serializer: ::Api::V1::FishingSpotLocationSerializer
        ).as_json

        json = { fishing_spot_locations: serialized_fishing_spot_locations }

        render json: json, status: :ok
      end
    end
  end
end

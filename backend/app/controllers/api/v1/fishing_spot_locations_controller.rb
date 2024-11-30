module Api
  module V1
    class FishingSpotLocationsController < ApplicationController
      # 釣り場の位置情報を取得する
      def index
        fishing_spot_locations = FishingSpotLocation.all
        serialized_fishing_spot_locations = ActiveModelSerializers::SerializableResource.new(
          fishing_spot_locations,
          each_serializer: ::Api::V1::FishingSpotLocationSerializer
        ).as_json

        json = { fishing_spot_locations: serialized_fishing_spot_locations }

        render json: json, status: :ok
      end

      # 釣り場位置から釣り場の詳細を取得する
      def fishing_spot
        fishing_spot_location = ::FishingSpotLocation.find_by(id: params[:id])

        if fishing_spot_location.nil?
          render_404_error(message: '釣り場が見つかりません') and return
        end

        fishing_spot = fishing_spot_location.fishing_spot

        serialized_fishing_spot = ::Api::V1::FishingSpotLocations::Show::FishingSpotSerializer.new(
          fishing_spot,
          fishing_spot_location: fishing_spot_location
        ).as_json

        render status: :ok, json: { fishing_spot: serialized_fishing_spot }
      end
    end
  end
end

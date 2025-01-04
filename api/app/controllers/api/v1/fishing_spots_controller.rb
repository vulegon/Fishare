module Api
  module V1
    class FishingSpotsController < ApplicationController
      before_action :authenticate_user!, only: %i[create destroy update]

      # 釣り場を検索します。
      def index
        searh_params = ::Api::V1::FishingSpots::SearchParameter.new(params)

        if searh_params.invalid?
          render_form_error(searh_params) and return
        end

        finder = ::Api::V1::FishingSpotFinder.new
        fishing_spots = finder.search(searh_params)

        json = ::Api::V1::FishingSpots::Index::PaginationSerializer.new(
          fishing_spots,
          count: finder.count(searh_params)
        ).as_json

        render status: :ok, json: json
      end

      # 釣り場を作成する
      def create
        create_params = ::Api::V1::FishingSpots::CreateParameter.new(params)

        if create_params.invalid?
          render_form_error(create_params) and return
        end

        create_spec = ::FishingSpots::CreateSpecification.new
        unless create_spec.satisfied_by?(current_user)
          render_403_error(message: create_spec.unsatisfied_reason) and return
        end

        result = ::Api::V1::FishingSpots::CreateService.create!(create_params)

        json = {
          message: '釣り場を作成しました',
          fishing_spot_location: ::Api::V1::FishingSpotLocationSerializer.new(result[:fishing_spot_location]).as_json
        }

        render status: :ok, json: json
      end

      def update
        update_params = ::Api::V1::FishingSpots::UpdateParameter.new(params)

        if update_params.invalid?
          render_form_error(update_params) and return
        end

        update_spec = ::FishingSpots::CreateSpecification.new
        unless update_spec.satisfied_by?(current_user)
          render_403_error(message: update_spec.unsatisfied_reason) and return
        end

        ::Api::V1::FishingSpots::UpdateService.update!(update_params)

        render status: :ok, json: { message: '釣り場を更新しました' }
      end

      # 釣り場位置から釣り場の詳細を取得する
      def show
        fishing_spot = ::FishingSpot.find_by(id: params[:id])

        if fishing_spot.nil?
          render_404_error(message: '釣り場が見つかりません') and return
        end

        fishing_spot_location = fishing_spot.fishing_spot_location

        serialized_fishing_spot = ::Api::V1::FishingSpotLocations::Show::FishingSpotSerializer.new(
          fishing_spot,
          fishing_spot_location: fishing_spot_location
        ).as_json

        render status: :ok, json: { fishing_spot: serialized_fishing_spot }
      end

      def destroy
        fishing_spot = FishingSpot.find_by(id: params[:id])

        if fishing_spot.nil?
          render_404_error(message: '釣り場が見つかりませんでした') and return
        end

        delete_spec = ::FishingSpots::CreateSpecification.new
        unless delete_spec.satisfied_by?(current_user)
          render_403_error(message: delete_spec.unsatisfied_reason) and return
        end

        ::Api::V1::FishingSpots::DestroyService.destroy!(fishing_spot)

        render status: :ok, json: { message: '釣り場を削除しました' }
      end
    end
  end
end

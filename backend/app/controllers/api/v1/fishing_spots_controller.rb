module Api
  module V1
    class FishingSpotsController < ApplicationController
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

        ::Api::V1::FishingSpots::CreateService.create!(create_params)

        render status: :ok, json: { message: '釣り場を作成しました' }
      end

      # 釣り場の詳細を取得する
      def show
        fishing_spot = ::FishingSpot.find_by(id: params[:id])

        if fishing_spot.nil?
          render_404_error(message: '釣り場が見つかりません') and return
        end

        serialized_fishing_spot = ::Api::V1::FishingSpots::Show::FishingSpotSerializer.new(fishing_spot).as_json

        render status: :ok, json: { fishing_spot: fishing_spot }
      end
    end
  end
end

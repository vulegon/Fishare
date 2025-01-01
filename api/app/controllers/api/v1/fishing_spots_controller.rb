module Api
  module V1
    class FishingSpotsController < ApplicationController
      before_action :authenticate_user!, only: %i[create]

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

        ::Api::V1::FishingSpots::CreateService.create!(create_params)

        render status: :ok, json: { message: '釣り場を作成しました' }
      end

      def update
        update_params = ::Api::V1::FishingSpots::UpdateParameter.new(params)

        if update_params.invalid?
          render_form_error(update_params) and return
        end

        fishing_spot = FishingSpot.find_by(id: params[:id])

        if fishing_spot.nil?
          render_404_error(message: '釣り場が見つかりませんでした') and return
        end

        update_spec = ::FishingSpots::CreateSpecification.new
        unless update_spec.satisfied_by?(current_user, fishing_spot)
          render_403_error(message: update_spec.unsatisfied_reason) and return
        end

        ::Api::V1::FishingSpots::UpdateService.update!(fishing_spot, update_params)

        render status: :ok, json: { message: '釣り場を更新しました' }
      end

      def show
        fishing_spot = FishingSpot.find_by(id: params[:id])

        if fishing_spot.nil?
          render_404_error(message: '釣り場が見つかりませんでした') and return
        end

        json = ::Api::V1::FishingSpots::Show::FishingSpotSerializer.new(fishing_spot).as_json

        render status: :ok, json: json
      end
    end
  end
end

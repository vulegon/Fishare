module Api
  module V1
    class FishingSpotsController < ApplicationController
      before_action :authenticate_user!

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

      # 画像をアップロードするための署名付きURLを生成する
      def generate_presigned_urls
        generate_presigned_urls_params = ::Api::V1::S3::PresignedUrlParameter.new(params)

        if generate_presigned_urls_params.invalid?
          render_form_error(generate_presigned_urls_params) and return
        end

        create_spec = ::FishingSpots::CreateSpecification.new
        unless create_spec.satisfied_by?(current_user)
          render_403_error(message: create_spec.unsatisfied_reason) and return
        end

        json = ::Api::V1::S3::ImageSerializer.new(generate_presigned_urls_params).as_json

        render status: :ok, json: json
      end
    end
  end
end

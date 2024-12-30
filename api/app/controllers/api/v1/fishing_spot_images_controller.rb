module Api
  module V1
    class FishingSpotImagesController < ApplicationController
      before_action :authenticate_user!

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

        json = ::Api::V1::S3::ImageSerializer.new(generate_presigned_urls_params, 'fishing_spots', 'fishing_spot_image_bucket').as_json

        render status: :ok, json: json
      end
    end
  end
end

module Api
  module V1
    module Supports
      class ContactImagesController < ::Api::V1::ApplicationController
        # お問い合わせ画像をアップロードする用のPresigned URLを生成する
        def generate_presigned_urls
          parameter = ::Api::V1::S3::PresignedUrlParameter.new(params)

          if parameter.invalid?
            render_form_error(parameter) and return
          end

          json = ::Api::V1::S3::ImageSerializer.new(parameter, 'supports/contact_images', 'support_contact_image_bucket').as_json

          render json: json, status: :ok
        end
      end
    end
  end
end

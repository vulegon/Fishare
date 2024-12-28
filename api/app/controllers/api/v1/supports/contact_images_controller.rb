module Api
  module V1
    module Supports
      class ContactImagesController < ::Api::V1::ApplicationController
        # お問い合わせ画像をアップロードする用のPresigned URLを生成する
        def generate_presigned_urls
          parameter = ::Api::V1::Supports::ContactImages::GeneratePresignedUrlsParameter.new(params)

          if parameter.invalid?
            render_form_error(parameter) and return
          end

          json = ::Api::V1::Supports::ContactImages::ImageSerializer.new(parameter).as_json

          render json: json, status: :ok
        end
      end
    end
  end
end

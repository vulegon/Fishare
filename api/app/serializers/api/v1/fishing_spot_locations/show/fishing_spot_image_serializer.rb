module Api
  module V1
    module FishingSpotLocations
      module Show
        class FishingSpotImageSerializer < ActiveModel::Serializer
          attributes :id, :s3_key, :file_name, :content_type, :presigned_url

          def initialize(object, options = {})
            super
            @s3_key = object.s3_key
            @s3_helper = ::LibAws::S3Helper.new
          end

          def presigned_url
            @s3_helper.get_presigned_url(
              bucket_name: Rails.configuration.x.lib_aws.s3[:fishing_spot_image_bucket],
              key: @s3_key,
              expires_in: 3600
            )
          end
        end
      end
    end
  end
end

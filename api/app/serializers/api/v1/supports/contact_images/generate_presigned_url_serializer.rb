module Api
  module V1
    module Supports
      module ContactImages
        class GeneratePresignedUrlSerializer
          def initialize(image_form)
            @image_form = image_form
            @s3_helper = ::LibAws::S3Helper.new
            @s3_key = @s3_helper.generate_s3_key(prefix: 'supports/contact_images', file_name: @image_form.file_name)
          end

          def as_json
            {
              presigned_url: @s3_helper.put_presigned_url(
                bucket_name: Rails.configuration.x.lib_aws.s3[:support_contact_image_bucket],
                key: @s3_key,
                content_type: @image_form.content_type
              ),
              s3_key: @s3_key,
            }
          end
        end
      end
    end
  end
end

module Api
  module V1
    module S3
      class ImageSerializer
        def initialize(parameter, prefix, bucket_name)
          @image_forms = parameter.image_forms
          @prefix = prefix
          @bucket_name = bucket_name.to_sym
        end

        def as_json
          {
            images: @image_forms.map do |image_form|
              PresignedUrlSerializer.new(image_form, @prefix, @bucket_name).as_json
            end
          }
        end
      end
    end
  end
end

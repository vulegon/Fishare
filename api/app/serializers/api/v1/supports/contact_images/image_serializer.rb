module Api
  module V1
    module Supports
      module ContactImages
        class ImageSerializer
          def initialize(parameter)
            @image_forms = parameter.image_forms
          end

          def as_json
            {
              images: @image_forms.map { |image_form| GeneratePresignedUrlSerializer.new(image_form).as_json }
            }
          end
        end
      end
    end
  end
end

module Api
  module V1
    module Supports
      module ContactImages
        class GeneratePresignedUrlsParameter
          include ActiveModel::Model
          include ActiveModel::Attributes

          attribute :images, array: true

          validate :images_must_be_valid, if: -> { images.present? }

          def initialize(params)
            permitted_params = params.permit(
              images: [:file_name, :content_type],
            )
            super(permitted_params.to_h.deep_symbolize_keys)
          end

          private

          def images_must_be_valid
            @image_forms = images.map{ |image| ImageForm.new(image) }

            error_messages = []

            @image_forms.each do |image_form|
              error_messages << image_form.errors.full_messages.join('。') if image_form.invalid?
            end

            return if error_messages.blank?

            errors.add(:images, error_messages.join('。'))
          end
        end
      end
    end
  end
end

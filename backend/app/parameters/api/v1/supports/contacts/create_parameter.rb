module Api
  module V1
    module Supports
      module Contacts
        class CreateParameter
          include ActiveModel::Model
          include ActiveModel::Attributes

          attribute :name, :string
          attribute :email, :string
          attribute :contact_content, :string
          attribute :images, array: true

          validates :name,:email, :contact_content, presence: true
          validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
          validates :name, length: { minimum: 2 , maximum: 50 }
          validates :contact_content, length: { minimum: 2 , maximum: 1000 }

          def initialize(params)
            permitted_params = params.permit(:name, :email, :contact_content, images: [:file_name, :s3_key, :content_type, :file_size, :s3_url])
            super(permitted_params.to_h.deep_symbolize_keys)
          end
        end
      end
    end
  end
end

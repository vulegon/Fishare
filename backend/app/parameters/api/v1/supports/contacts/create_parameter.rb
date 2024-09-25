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
          attribute :images, :array

          validates :name,:email, :contact_content, presence: true
          validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
          validates :contact_content, length: { minimum: 2 , maximum: 1000 }

          def initialize(params)
            super(params.permit(:name, :email, :contact_content, :name, images: []))
          end
        end
      end
    end
  end
end

module Api
  module V1
    module Supports
      module Contacts
        class CreateParameter
          include ActiveModel::Model
          include ActiveModel::Attributes

          attribute :name, :string
          attribute :email, :string
          attribute :content, :string
          attribute :images, array: true
          attribute :contact_category, :string

          validates :name,:email, :content, presence: true
          validates :email, email_format: true
          validates :name, length: { minimum: 2 , maximum: 50 }
          validates :content, length: { minimum: 10 , maximum: 1000 }

          validate :contact_category_exists

          def initialize(params)
            permitted_params = params.permit(:name, :email, :content, :contact_category, images: [:file_name, :s3_key, :content_type, :file_size, :s3_url])
            super(permitted_params.to_h.deep_symbolize_keys)
            @support_contact_category = ::Supports::ContactCategory.find_by(name: contact_category)
          end

          private

          attr_reader :support_contact_category

          def contact_category_exists
            return if support_contact_category.present?

            errors.add(:contact_category, 'が見つかりません')
          end
        end
      end
    end
  end
end

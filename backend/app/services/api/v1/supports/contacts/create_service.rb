module Api
  module V1
    module Supports
      module Contacts
        class CreateService
          class << self
            # お問い合わせを作成する
            # @param params [Api::V1::Supports::Contacts::CreateParameter]
            # @return [Supports::Contact] 永続化されたお問い合わせ
            def create!(params)
              contact = ::Supports::ContactFactory.new.build(params)
              contact_images = ::Supports::ContactImageFactory.new.build_all(params.images, contact.id)

              ActiveRecord::Base.transaction do
                ::Supports::ContactRepository.save!(contact)
              end

              contact
            end
          end
        end
      end
    end
  end
end

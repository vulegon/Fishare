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
              contact = ::Supports::ContactFactory.new.build(params, params.support_contact_category.id)
              contact_images = ::Supports::ContactImageFactory.new.build_all(params.images, contact.id)

              ActiveRecord::Base.transaction do
                ::Supports::ContactRepository.save!(contact)
                ::Supports::ContactImageRepository.save_all!(contact_images)
              end

              ::Supports::ContactMailer.send_complete_mail(contact).deliver_later
              contact
            end
          end
        end
      end
    end
  end
end

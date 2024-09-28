module Api
  module V1
    module Supports
      class ContactsController < ::Api::V1::ApplicationController
        def create
          create_params = ::Api::V1::Supports::Contacts::CreateParameter.new(params)

          if create_params.invalid?
            render_form_error(create_params) and return
          end

          ::Api::V1::Supports::Contacts::CreateService.create!(create_params)

          render status: :ok, json: { message: 'お問い合わせを受け付けました' }
        end
      end
    end
  end
end

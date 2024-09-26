module Api
  module V1
    class ApplicationController < ApplicationController
      rescue_from StandardError, with: :render_500 # 一番最後に書くこと

      def render_form_error(form, message: nil)
        message = message || form.errors.full_messages.join(",") || 'パラメータが不正です'

        render status: :bad_request, json: { message: message, errors: form.errors }
      end

      def render_500(error)
        message = 'システムエラーが発生しました。サポートにお問い合わせください'
        json = { message: message, errors: error.message }
        render status: :internal_server_error, json: json
      end
    end
  end
end

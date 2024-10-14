module Api
  module V1
    class ApplicationController < ApplicationController
      rescue_from StandardError, with: :render_500 # 一番最後に書くこと

      def authenticate_user!
        unless auth_access_token && auth_uid && auth_client
          render json: { message: '認証情報が不正です' }, status: :unauthorized and return
        end

        unless current_user
          render json: { message: 'ログインしてください' }, status: :unauthorized and return
        end
      end

      def current_user
        @current_user ||= ::User.find_by_auth_token(auth_access_token, auth_client, auth_uid)
      end

      def render_form_error(form, message: nil)
        message = message || form.errors.full_messages.join(",") || 'パラメータが不正です'

        render status: :bad_request, json: { message: message, errors: form.errors }
      end

      def render_403_error(message: nil)
        message = message || '権限がありません'

        render status: :forbidden, json: { message: message }
      end

      def render_500(error)
        message = 'システムエラーが発生しました。サポートにお問い合わせください'
        json = { message: message, errors: error.message }
        render status: :internal_server_error, json: json
      end

      private

      # Cookieから認証情報を取得しますが、スマートフォンアプリ用のことも考えてヘッダーからも取得できるようにしています
      def auth_access_token
        @auth_access_token ||= cookies_access_token || request.headers['access-token']
      end

      def auth_uid
        @auth_uid ||= cookies_uid || request.headers['uid']
      end

      def auth_client
        @auth_client ||= cookies_client || request.headers['client']
      end

      def cookies_access_token
        @cookies_access_token ||= cookies.signed[:access_token]
      end

      def cookies_uid
        @cookies_uid ||= cookies.signed[:uid]
      end

      def cookies_client
        @cookies_client ||= cookies.signed[:client]
      end
    end
  end
end

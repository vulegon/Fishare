module Api
  module V1
    class UsersController < Api::V1::ApplicationController
      # ログインしているかどうかの確認
      def show_current_user
        message = 'ユーザー情報を取得しました'

        unless current_user
          render json: { message: message, user: nil }, status: :ok and return
        end

        json = {
          message: message,
          user: {
            id: current_user.id,
            email: current_user.email,
            name: current_user.name,
            is_admin: current_user.admin?,
          },
        }

        render status: :ok, json: json
      end
    end
  end
end

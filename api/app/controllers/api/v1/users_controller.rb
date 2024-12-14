module Api
  module V1
    class UsersController < Api::V1::ApplicationController
      # ログインしているかどうかの確認
      def show_current_user
        return render status: :ok, json: { user: nil } unless current_user

        json = {
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

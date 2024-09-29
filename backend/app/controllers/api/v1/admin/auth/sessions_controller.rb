module Api
  module V1
    module Admin
      module Auth
        class SessionsController < Devise::SessionsController
          # 管理者ログイン処理
          def create
            self.resource = warden.authenticate!(auth_options)

            # 管理者でない場合、ログアウトしてエラーレスポンスを返す
            unless resource.admin?
              sign_out resource
              return render json: { message: '管理者権限を持っていません' }, status: :unauthorized
            end

            # 管理者の場合、通常のトークン認証処理
            create_new_auth_token = resource.create_new_auth_token
            json = {
              data: resource.as_json(only: [:id, :name, :email]),
              token: create_new_auth_token
            }

            render status: :ok, json: json
          end
        end
      end
    end
  end
end

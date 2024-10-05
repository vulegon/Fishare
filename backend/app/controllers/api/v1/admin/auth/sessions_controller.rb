module Api
  module V1
    module Admin
      module Auth
        class SessionsController < DeviseTokenAuth::SessionsController
          include ::Admin::UserHelper

          # 管理者ログイン処理
          def create
            user = User.find_by(email: params[:email])

            unless user && user.valid_password?(params[:password])
              return render json: { message: 'メールアドレスまたはパスワードに誤りがあります' }, status: :unauthorized
            end

            unless user.admin?
              return render json: { message: '管理者権限を持っていません' }, status: :forbidden
            end

            auth_token = user.create_new_auth_token
            response.headers.merge!(auth_token)

            json = {
              message: 'ログインに成功しました',
              user: {
                id: user.id,
                email: user.email,
                name: user.name,
                is_admin: user.admin?,
              },
            }

            render status: :ok, json: json
          end

          # 管理者のログアウト処理
          def destroy
            client = request.headers['client']
            token = request.headers['access-token']
            uid = request.headers['uid']

            if client.blank? || token.blank? || uid.blank?
              return render json: { message: '認証情報が不足しています' }, status: :unauthorized
            end

            if current_user.nil? || current_user.tokens[client].nil?
              return render json: { message: 'ユーザーが見つかりません' }, status: :not_found
            end

            current_user.tokens.delete(client)
            current_user.save
            render json: { message: 'ログアウトしました' }, status: :ok
          end
        end
      end
    end
  end
end

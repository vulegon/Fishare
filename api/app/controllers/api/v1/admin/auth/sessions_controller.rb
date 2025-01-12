module Api
  module V1
    module Admin
      module Auth
        class SessionsController < Api::V1::ApplicationController
          before_action :authenticate_user!, only: :destroy

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
            set_cookies(auth_token)

            # スマートフォンアプリ用のヘッダー情報を設定(予定)
            response.headers['access-token'] = auth_token['access-token']
            response.headers['client'] = auth_token['client']
            response.headers['uid'] = auth_token['uid']

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
            current_user.tokens.delete(auth_client)
            current_user.save

            delete_cookies
            render json: { message: 'ログアウトしました' }, status: :ok
          end

          private

          # 管理者のCookieの有効期限は1時間とする。
          def set_cookies(auth_token)
            { access_token: auth_token['access-token'], uid: auth_token['uid'], client: auth_token['client'] }.each do |key, value|
              cookies.signed[key] = {
                value: value,
                http_only: true,
                secure: Rails.env.production?,
                expires: 1.hour.from_now,
              }
            end
          end

          def delete_cookies
            cookies.delete(:access_token, httponly: true, secure: Rails.env.production?)
            cookies.delete(:uid, httponly: true, secure: Rails.env.production?)
            cookies.delete(:client, httponly: true, secure: Rails.env.production?)
          end
        end
      end
    end
  end
end

module Api
  module V1
    module Admin
      class UserService
        class << self
          # 管理者ユーザーを作成する
          # @param email [String] メールアドレス
          # @param password [String] パスワード
          # @param name [String] 名前
          def create_admin_user!(email, password, name: 'admin')
            role = UserRole.find_by!(role: :admin)
            admin_user = ::User.new(name: name, email: email, password: password, password_confirmation: password)

            ActiveRecord::Base.transaction do
              admin_user.save!
              admin_user.user_roleships.create!(user_role: role)
            end

            admin_user
          end
        end
      end
    end
  end
end
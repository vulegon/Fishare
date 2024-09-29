module Api
  module V1
    module Users
      class CreateService
        class << self
          # 指定した権限を持つユーザーを作成する
          # @param email [String] メールアドレス
          # @param password [String] パスワード
          # @param role [UserRole] ユーザー権限
          # @param name [String] 名前
          def create_user_with_role!(name, email, password, role)
            user = ::User.new(name: name, email: email, password: password, password_confirmation: password)

            ActiveRecord::Base.transaction do
              user.save!
              user.user_roleships.create!(user_role: role)
            end

            user
          end
        end
      end
    end
  end
end

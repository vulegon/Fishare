module TestData
  class UserLoader
    class << self
      def load
        users = User.joins(:user_roles).where(user_roles: { role: :admin })
        return if users.present?

        ActiveRecord::Base.transaction do
          admin_role = ::UserRole.find_or_create_by!(role: :admin)

          1..5.times do |i|
            name = "管理者_#{i}"
            email = "test_admin#{i}@fishare.com"
            password = "Password123"
            ::Api::V1::Users::CreateService.create_user_with_role!(name, email, password, admin_role)
          end
        end
      end
    end
  end
end

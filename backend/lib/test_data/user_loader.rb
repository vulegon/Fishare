module TestData
  class UserLoader
    class << self
      def load
        ActiveRecord::Base.transaction do
          admin_role = ::UserRole.find_or_create_by!(role: :admin)

          1..5.times do |i|
            admin_user = ::User.new(name: "管理者_#{i}", email: "test_admin#{i}@fishare.com", password: "password123", password_confirmation: "password123")
            admin_user.save!
            admin_user.user_roleships.create!(user_role: admin_role)
          end
        end
      end
    end
  end
end

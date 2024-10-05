module Admin
  module UserHelper
    extend ActiveSupport::Concern

    def current_user
      current_api_v1_admin_user
    end
  end
end

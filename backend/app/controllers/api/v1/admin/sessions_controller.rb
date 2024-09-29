module Api
  module V1
    module Admin
      class SessionsController < Devise::SessionsController

        def create
          self.resource = warden.authenticate!(auth_options)

          if !resource.admin? # 管理者でない場合
            sign_out resource # 認証を無効化
            redirect_to admin_sign_in_path and return
          end

          sign_in(resource_name, resource)
          redirect_to admin_dashboards_path
        end
      end
    end
  end
end

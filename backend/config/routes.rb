Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :prefectures, only: [:index]

      namespace :supports do
        resource :contact, only: [:create]
      end

      namespace :admin do
        get 'dashboards', to: 'dashboards#index'

        mount_devise_token_auth_for 'User', at: 'auth', controllers: {
          sessions: 'api/v1/admin/auth/sessions'
        }
      end
    end
  end
end

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :prefectures, only: [:index]

      namespace :supports do
        resource :contact, only: [:create]
      end

      # 管理者用のダッシュボードやその他の管理ページ
      namespace :admin do
        get 'dashboards', to: 'dashboards#index' # 管理者用のダッシュボード

        # devise_scope :user do
        #   post 'sign_in', to: 'sessions#create'
        #   delete 'sign_out', to: 'sessions#destroy'
        # end
      end
    end
  end
end

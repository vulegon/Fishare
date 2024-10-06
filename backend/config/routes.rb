Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :prefectures, only: [:index]

      namespace :supports do
        resource :contact, only: [:create]
      end

      namespace :admin do
        get 'dashboards', to: 'dashboards#index'

        namespace :auth do
          post 'sign_in', to: 'sessions#create'
          delete 'sign_out', to: 'sessions#destroy'
        end
      end
    end
  end
end

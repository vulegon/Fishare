Rails.application.routes.draw do
  devise_for :users
  namespace :api do
    namespace :v1 do
      resources :prefectures, only: [:index]

      namespace :supports do
        resource :contact, only: [:create]
      end
    end
  end
end

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :prefectures, only: [:index]

      namespace :supports do
        resources :contacts, only: [:create]
      end
    end
  end
end

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

      get 'users/current_user', to: 'users#show_current_user'

      resources :fishes, only: %i[index]
      resources :fishing_spots, only: %i[create]
      resources :fishing_spot_locations, only: %i[index]
      get 'fishing_spot_locations/:id/fishing_spot', to: 'fishing_spot_locations#fishing_spot', as: 'fishing_spot_location_fishing_spot'
    end
  end
end
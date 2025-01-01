Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'health_check', to: proc { [200, { 'Content-Type' => 'application/json' }, ['{"status":"ok"}']] }

      resources :prefectures, only: [:index]

      namespace :supports do
        resource :contact, only: [:create]

        post 'contact_images/generate_presigned_urls', to: 'contact_images#generate_presigned_urls'
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
      resources :fishing_spots, only: %i[index create]
      post 'fishing_spot_images/generate_presigned_urls', to: 'fishing_spot_images#generate_presigned_urls'

      resources :fishing_spot_locations, only: %i[index]
      get 'fishing_spot_locations/:id/fishing_spot', to: 'fishing_spot_locations#fishing_spot', as: 'fishing_spot_location_fishing_spot'
    end
  end
end

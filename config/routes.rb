Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :v1 do
    scope format: false do
      resources :geolocations, constraints: { id: /.+/ }, only: %i[show destroy]
      post '/geolocations/:id', to: 'geolocations#create', constraints: { id: /.+/ }
    end
  end
end

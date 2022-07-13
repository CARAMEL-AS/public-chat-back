Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'home#index'

  # AUTH ROUTES
  resources :user
  get '/find/friend', to: 'user#allUsers'
  post 'user/:id/signout', to: 'user#logout'

  # MESSAGES ROUTES
  resources :message, only: [:index, :create]

  # APPWARNING ROUTES
  get '/clear/warning', to: 'appwarning#apologies'

end

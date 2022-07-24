Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'home#index'

  # AUTH ROUTES
  resources :user
  post 'user/:id/signout', to: 'user#logout'
  post 'user/:id/verify', to: 'user#accVerify'

  # MESSAGES ROUTES
  resources :message, only: [:create]

  # APPWARNING ROUTES
  post '/clear/warning', to: 'appwarning#apologies'

  #GROUP (ONE : ONE) ROUTES
  get '/group/all', to: 'group#getMyGroups'
  post '/group/new', to: 'group#newGroup'
  post '/group/:id/delete', to: 'group#deleteGroup'

  # SETTINGS ROUTES
  post 'setting/update/:id/lang', to: 'setting#updateLanguage'
  post 'setting/update/:id/updateTheme', to: 'setting#updateTheme'

end

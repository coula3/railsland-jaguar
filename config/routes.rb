Rails.application.routes.draw do
  get '/users/workspace', to: 'users#workspace', as: 'user_workspace'

  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

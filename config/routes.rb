Rails.application.routes.draw do
  root 'application#home'
  get '/signin', to: 'session#signin'
  get '/users/workspace', to: 'users#workspace', as: 'user_workspace'

  resources :users
  resources :session, only: [:create, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

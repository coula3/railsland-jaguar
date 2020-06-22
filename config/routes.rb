Rails.application.routes.draw do
  root 'application#home'
  get '/signup', to: 'users#signup'
  get '/signin', to: 'session#signin'
  post '/session', to: 'session#create'
  get '/signout', to: 'session#destroy'
  get '/users/workspace', to: 'users#workspace', as: 'user_workspace'

  resources :users, only: [:create, :show, :index, :edit, :update, :destroy]
end

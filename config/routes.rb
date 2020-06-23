Rails.application.routes.draw do
  root 'session#new'
  post '/signin', to: 'session#create'
  get '/signup', to: 'users#new'
  get '/signout', to: 'session#destroy'
  get '/users/workspace', to: 'users#workspace', as: 'user_workspace'
  get '/auth/facebook/callback', to: 'session#create'

  resources :users, only: [:create, :show, :index, :edit, :update, :destroy]
end

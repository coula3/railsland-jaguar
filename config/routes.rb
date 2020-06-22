Rails.application.routes.draw do
  root 'application#home'
  get '/signin', to: 'session#signin'
  post '/session', to: 'session#create'
  delete '/session', to: 'session#destroy'
  get '/users/workspace', to: 'users#workspace', as: 'user_workspace'

  resources :users
end

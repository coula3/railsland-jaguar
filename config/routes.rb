Rails.application.routes.draw do
  root 'session#new'
  post '/signin', to: 'session#create'
  get '/signup', to: 'users#new'
  get '/signout', to: 'session#destroy'
  get '/users/workspace', to: 'users#workspace', as: 'user_workspace'
  get '/auth/facebook/callback', to: 'session#create'
  get '/users/:id/admin_edit', to: 'users#admin_edit', as: 'admin_edit'

  resources :users, only: [:create, :show, :index, :edit, :update, :destroy]
  resources :customers
  resources :services
  resources :appointments
end

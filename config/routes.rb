Rails.application.routes.draw do
  # get 'customers/new'
  # get 'customers/create'
  # get 'customers/index'
  # get 'customers/show'
  # get 'customers/edit'
  # get 'customers/update'
  # get 'customers/destroy'
  root 'session#new'
  post '/signin', to: 'session#create'
  get '/signup', to: 'users#new'
  get '/signout', to: 'session#destroy'
  get '/users/workspace', to: 'users#workspace', as: 'user_workspace'
  get '/auth/facebook/callback', to: 'session#create'
  get '/users/:id/admin_edit', to: 'users#admin_edit', as: 'admin_edit'

  resources :users, only: [:create, :show, :index, :edit, :update, :destroy]
  resources :customers
end

Rails.application.routes.draw do
  root 'sessions#new'
  post '/signin', to: 'sessions#create'
  get '/signup', to: 'users#new'
  get '/signout', to: 'sessions#destroy'
  get '/users/workspace', to: 'users#workspace', as: 'user_workspace'
  get '/auth/facebook/callback', to: 'sessions#create'
  get '/users/:id/admin_edit', to: 'users#admin_edit', as: 'admin_edit'
  get '/customers/with_service_insurance', to: 'customers#with_service_insurance', as: 'service_insurance'

  resources :dealers, only: [:edit, :update]
  resources :users, only: [:create, :show, :index, :edit, :update, :destroy]
  resources :customers do 
    resources :appointments, only: [:new, :show, :index, :edit]
  end
  resources :services
  resources :appointments
end

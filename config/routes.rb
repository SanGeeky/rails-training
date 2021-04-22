# frozen_string_literal: true

Rails.application.routes.draw do
  root 'articles#index'
  resources :articles do
    resources :comments, only: %i[create destroy]
  end
  # Users Routes
  get '/signup' => 'users#new'
  post '/users' => 'users#create'
  # Session Routes
  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  get '/signout' => 'sessions#destroy'
end

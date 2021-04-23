# frozen_string_literal: true

Rails.application.routes.draw do
  root 'articles#index'
  resources :articles do
    resources :comments, only: %i[create destroy]
  end
  # Users Routes
  get '/signup', to:'users#new'
  post '/signup', to:'users#create'
  # Session Routes
  get '/signin', to:'sessions#new'
  post '/signin', to:'sessions#create'
  get '/signout', to:'sessions#destroy'
end

# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'welcome#index'
  get '/login', to: 'users#login'
  post '/login', to: 'users#login_user'
  post '/logout', to: 'users#logout'
  get '/register', to: 'users#new'
  get '/dashboard', to: 'users#show'
  get 'discover', to: 'users/discover#index'
  resources :users, only: [:create]
  resources :movies, only: %i[index show], controller: 'users/movies' do
    resources :viewing_parties, only: %i[new create], controller: 'users/viewing_parties'
  end
  namespace :admin do
    resources :users, only: [:show]
  end
end

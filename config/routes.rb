# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root 'application#home'
  get '/register', to: 'users#new'
  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login'

  resources :users, only: %i[new create show] do
    resources :discover, only: %i[index]
    resources :movies, only: %i[index show] do
      resources :viewing_parties, only: %i[new create]
    end
  end
end

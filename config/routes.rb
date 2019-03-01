Rails.application.routes.draw do
  mount RailsAdmin::Engine => "/admin", as: "rails_admin"
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  root "static_pages#home"
  devise_for :users, controllers: {sessions: "users/sessions", registrations: "users/registrations" }
  resources :users
  resources :words
  resources :courses, only: [:index]
  resources :searchs
  resources :relationships, only: [:create, :destroy]
  resources :lessons do
    resources :results, only: [:index]
  end
  resources :lessons
end

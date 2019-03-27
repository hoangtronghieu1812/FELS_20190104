Rails.application.routes.draw do
  require "sidekiq/web"
  mount RailsAdmin::Engine => "/admin", as: "rails_admin"
  mount Sidekiq::Web => "/sidekiq"
  devise_for :users, controllers: {omniauth_callbacks:
    "users/omniauth_callbacks",sessions: "users/sessions"}
  root "static_pages#home"
  get "/facebook/login", to: "facebooks#login", as: "login"
  get "/facebook/login/success", to: "facebooks#login_success", as: "success"

  resources :users
  resource :facebook
  resources :words, only: [:index]
  resources :courses, only: [:index]
  resources :searchs
  resources :relationships, only: [:create, :destroy]
  resources :lessons do
    resources :results, only: [:index]
  end
  resources :lessons
end

Rails.application.routes.draw do
  root "static_pages#home"
  devise_for :users
  resources :users
  resources :words, only: [:index]
  resources :courses, only: [:index]
  resources :searchs
  resources :relationships, only: [:create, :destroy]
  resources :lessons do
    resources :results, only: [:index]
  end
  resources :lessons
end

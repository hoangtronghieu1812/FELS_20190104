Rails.application.routes.draw do
  root "static_pages#home"
  devise_for :users
  resources :words, only: [:index]
  resources :courses, only: [:index]
end

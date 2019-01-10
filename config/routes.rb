Rails.application.routes.draw do
  root "static_pages#show"
  devise_for :users
  resources :words, only: [:index]
end

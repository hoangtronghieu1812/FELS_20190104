Rails.application.routes.draw do
  root "static_pages#show"
  resources :words, only: [:index]
  devise_for :users
end

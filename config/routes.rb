Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :transport_models, only: %i[index show new create edit update]
  resources :carriers, only: %i[index show new create edit update]
  resources :order_of_services, only: %i[index show new create edit update]
  resources :price_by_weights, only: %i[index create update]
end

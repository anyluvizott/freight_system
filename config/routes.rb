Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  get 'search', to: 'home#search'

  resources :transport_models, only: %i[index show new create edit update]
  resources :carriers, only: %i[index show new create edit update] do
    post 'active', on: :member
    post 'on_delivery', on: :member
    post 'under_maintenance', on: :member
    get 'search', on: :collection
  end

  resources :price_by_weights, only: %i[index create update]
  resources :price_per_distances, only: %i[index create update]
  resources :delivery_times, only: %i[index create update]

  resources :order_of_services, only: %i[index show new create edit update] do
    resources :start_service_orders, only: [:create]
    post 'on_route', on: :member
    post 'delivered', on: :member
    get 'search', on: :collection
  end
end

# Prefix                         Verb                         URI Pattern          Controller#Action
# order_of_service_start_service_orders POST   /order_of_services/:order_of_service_id/start_service_orders(.:format) start_service_orders#create
# search_carriers GET    /carriers/search(.:format)   carriers#search

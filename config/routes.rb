Rails.application.routes.draw do
root to: 'home#index'

resources :transport_models, only: [:index, :show, :new, :create]
end

#Prefix         Verb             URI Pattern         Controller#Action
#root             GET    /                             home#index
#transport_models GET    /transport_models(.:format)  transport_models#index
#                  POST   /transport_models(.:format)  transport_models#create
#new_transport_model GET    /transport_models/new(.:format)  transport_models#new
#transport_model      GET    /transport_models/:id(.:format) transport_models#show
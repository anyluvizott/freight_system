Rails.application.routes.draw do
root to: 'home#index'

resources :transport_models, only: [:index, :show, :new, :create, :edit, :update]
resources :carriers, only: [:index, :show, :new, :create, :edit, :update]
end


#Prefix Verb   URI Pattern             Controller#Action
 #                        root GET    / home#index
  #           transport_models GET    /transport_models(.:format) transport_models#index
   #                           POST   /transport_models(.:format) transport_models#create
    #      new_transport_model GET    /transport_models/new(.:format) transport_models#new
     #    edit_transport_model GET    /transport_models/:id/edit(.:format) transport_models#edit
      #        transport_model GET    /transport_models/:id(.:format) transport_models#show
       #                       PATCH  /transport_models/:id(.:format) transport_models#update
        #                      PUT    /transport_models/:id(.:format) transport_models#update

#        carriers              GET    /carriers(.:format) carriers#index
#                              POST   /carriers(.:format)         carriers#create
# new_carrier                   GET    /carriers/new(.:format)  carriers#new
# edit_carrier                  GET    /carriers/:id/edit(.:format) carriers#edit
# carrier                       GET    /carriers/:id(.:format)        carriers#show
#                             PATCH  /carriers/:id(.:format)        carriers#update
#                              PUT    /carriers/:id(.:format)        carriers#update
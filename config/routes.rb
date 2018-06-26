Rails.application.routes.draw do
  namespace :v1 do
    resource :auth, only: %i[create]
    resource :horses do
      get '/:id', to: 'horses#show', as: 'horse'
      get '/:id/getVets' => 'horses#getVets', as: 'getVets'
      get '/:id/getClients' => 'horses#getClients', as: 'getClients'
      get '/:id/getCurrentOwner' => 'horses#getCurrentOwner', as: 'getCurrentOwner'
      get '/:id/getCurrentVet' => 'horses#getCurrentVet', as: 'getCurrentVet'
      get '/' => 'horses#index', as: 'horses'
      get '/:id/historyOfOwners' => 'horses#historyOfOwners', as: 'historyOfOwners'
      get '/:id/historyOfVets' => 'horses#historyOfVets', as: 'historyOfVets'
      post '/:id/sell' => 'horses#sell', as: 'sell'
      post '/:id/changeVet' => 'horses#changeVet', as: 'changeVet'
      post '/:id/addVet' => 'horses#addVet', as: 'addVet'
      post '/:id/deleteVet' => 'horses#deleteVet', as: 'deleteVet'

    end
    resource :users do
      get '/' => 'users#index', as: 'users'
    end
    resource :clients do
      get '/:id/gethorses' => 'clients#getHorses', as: 'horse'
      get '/:id/getVets' => 'clients#getVets', as: 'getVets'
      get '/' => 'clients#index', as: 'clients'
    end
    resource :vets do
      get '/:id/gethorses' => 'vets#getHorses', as: 'horse'
      get '/' => 'vets#index', as: 'vets'
    end
  end


  scope :api, defaults: {format: :json} do
    devise_for :users, controllers: {sessions: 'sessions'}
    devise_scope :user do
      get 'users/current', to: 'sessions#show'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

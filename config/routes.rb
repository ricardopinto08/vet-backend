Rails.application.routes.draw do
  namespace :v1 do
    resource :auth, only: %i[create]
    resource :horses
    resource :users
    resource :clients
    resource :vets
  end


  scope :api, defaults: {format: :json} do
    devise_for :users, controllers: {sessions: 'sessions'}
    devise_scope :user do
      get 'users/current', to: 'sessions#show'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

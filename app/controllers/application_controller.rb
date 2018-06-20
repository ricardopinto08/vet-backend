class ApplicationController < ActionController::API
  devise_group :user, contains: [:client, :vet]
end

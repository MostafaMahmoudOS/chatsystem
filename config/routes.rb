Rails.application.routes.draw do
  devise_for :clients, controllers: { registrations: 'api/v1/clients/registrations' }
  devise_for :users, controllers: { registrations: 'api/v1/users/registrations' }
  namespace :api do
    namespace :v1 do
      namespace :clients do
        post :auth, to: 'authentication#create'
        get  '/auth' => 'authentication#fetch'
      end
    end
  end
end
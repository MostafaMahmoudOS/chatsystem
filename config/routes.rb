Rails.application.routes.draw do
  
  devise_for :clients, controllers: { registrations: 'api/v1/clients/registrations' }
  devise_for :users, controllers: { registrations: 'api/v1/users/registrations' }
  namespace :api do
    namespace :v1 do
      namespace :clients do
        post :auth, to: 'authentication#create'
        get  '/auth' => 'authentication#fetch'
      end
      namespace :users do
        post :auth, to: 'authentication#create'
        get  '/auth' => 'authentication#fetch'
      end
      resources :applications , param: :token do
        resources :chats , param: :number do
          member do
            delete :member, param: :token, to: 'chats#removeChatMember'
            put :member, param: :token, to: 'chats#addChatMember'
          end
          resources :messages , param: :number
        end
      end
    end
  end
end
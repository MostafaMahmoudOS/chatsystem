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
            put :removeChatMember, param: :token
            put :addChatMember, param: :token
          end
        end
      end
      get 'chat/addChatMember'
      get 'chat/removeChatMember'
      get 'post/index'
    end
  end
end
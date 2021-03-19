Rails.application.routes.draw do
  devise_for :clients, controllers: { registrations: 'api/v1/clients/registrations' }
end
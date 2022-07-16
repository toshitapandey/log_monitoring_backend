Rails.application.routes.draw do
  resources :messages
  mount ActionCable.server => '/cable'
end
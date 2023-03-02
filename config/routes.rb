Rails.application.routes.draw do
   devise_for :users
   root to: 'users#index'
   resources :users, only: [:index]do
      member do
         get :chat
      end
   end
  resources :messages, only: [:create]
end

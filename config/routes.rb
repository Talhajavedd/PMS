Rails.application.routes.draw do
  root 'projects#index'
  devise_for :users
  namespace :admin do
    resources :users do
      member do
        patch 'set_user_activiation'
      end
    end
    resources :clients
    resources :admins, only: [:index], as: 'root'
  end
  resources :clients
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html  
end

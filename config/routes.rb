Rails.application.routes.draw do
  resources :projects
  root 'projects#index'
  devise_for :users
  namespace :admin do
    resources :users do
      member do
        patch 'set_user_activation'
      end
    end
    resources :clients
    resources :admins, only: [:index], as: 'root'
    resources :projects
  end
  resources :clients
  resources :payments
  match "*path", to: "exceptions#catch_404", via: :all
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html  
end

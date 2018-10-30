Rails.application.routes.draw do
  root 'projects#index'
  devise_for :users
  namespace :admin do
    resources :users
    patch "/users/set_user_activiation/:id", to: "users#set_user_activiation", as: :user_activation
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html  
end

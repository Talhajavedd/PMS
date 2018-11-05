Rails.application.routes.draw do
  resources :projects do
    get 'delete'
    resources :payments do
      get 'delete'
    end
    resources :time_logs do
      get 'delete'
    end
  end
  root 'projects#index'
  devise_for :users
  namespace :admin do
    resources :users do
      member do
        patch 'set_user_activation'
      end
      get 'delete'
    end
    resources :clients do
      get 'delete'
    end
    resources :admins, only: [:index], as: 'root'
    resources :projects do
      get 'delete'
      resources :payments do
        get 'delete'
      end
      resources :time_logs do
        get 'delete'
      end
    end
  end
  resources :clients do
    get 'delete'
  end
  match '*path', to: 'exceptions#catch_404', via: :all
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

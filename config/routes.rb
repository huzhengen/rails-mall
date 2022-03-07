Rails.application.routes.draw do
  root 'welcome#index'
  delete '/logout' => 'sessions#destroy'
  # delete '/logout' => 'sessions#destroy', as: :logout

  resources :users
  resources :sessions
  resources :categories, only: [:show]
  resources :products, only: [:show]
  resources :shopping_carts
  resources :orders
  resources :addresses do
    member do
      put :set_default_address
    end
  end
  resources :payments, only: [:index] do
    collection do
      get :generate_pay
      get :pay_return
      get :pay_notify
      get :success
      get :failed
    end
  end

  namespace :dashboard do
    resources :orders, only: [:index]
    resources :addresses, only: [:index]
    scope 'profile' do
      controller :profile do
        get :password
        put :update_password
      end
    end
  end

  namespace :admin do
    root 'sessions#new'
    resources :sessions
    resources :products do
      resources :product_images, only: [:index, :create, :destroy, :update]
    end
    resources :categories
  end
end

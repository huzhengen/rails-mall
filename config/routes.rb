Rails.application.routes.draw do
  root 'welcome#index'
  delete '/logout' => 'sessions#destroy'
  # delete '/logout' => 'sessions#destroy', as: :logout

  resources :users
  resources :sessions
  resources :categories, only: [:show]
  resources :products, only: [:show]

  namespace :admin do
    root 'sessions#new'
    resources :sessions
    resources :products do
      resources :product_images, only: [:index, :create, :destroy, :update]
    end
    resources :categories
  end
end

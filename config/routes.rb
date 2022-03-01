Rails.application.routes.draw do
  root 'welcome#index'
  delete '/logout' => 'sessions#destroy'
  # delete '/logout' => 'sessions#destroy', as: :logout

  resources :users
  resources :sessions

  namespace :admin do
    root 'sessions#new'
    resources :sessions
    resources :products do
      resources :product_images, only: [:index, :create, :destroy]
    end
    resources :categories
  end
end

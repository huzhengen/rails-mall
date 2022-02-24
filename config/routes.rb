Rails.application.routes.draw do
  root 'welcome#index'
  delete '/logout' => 'sessions#destroy'
  # delete '/logout' => 'sessions#destroy', as: :logout

  resources :users
  resources :sessions
end

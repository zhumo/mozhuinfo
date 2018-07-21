Rails.application.routes.draw do
  resources :blogs
  resources :users

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  root "home#index"
end

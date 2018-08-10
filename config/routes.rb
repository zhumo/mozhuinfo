Rails.application.routes.draw do
  resources :blogs

  resources :contacts do
    resources :pings, only: [:new, :create, :edit, :update, :destroy]
  end

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  root "home#index"
end

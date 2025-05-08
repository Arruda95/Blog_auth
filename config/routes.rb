Rails.application.routes.draw do
  root "posts#index"

  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  delete 'logout', to: 'sessions#destroy'

  resources :posts do
    resources :comments, only: [:create, :destroy]
  end 
end

Rails.application.routes.draw do
  root "home#index"

  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  delete 'logout', to: 'sessions#destroy'

  # Rota para o feed RSS
  get 'feed', to: 'posts#feed', defaults: { format: 'rss' }

  # Novas rotas para categorias e contato
  get 'categories', to: 'categories#index'
  get 'contact', to: 'contacts#index'

  resources :posts do
    resources :comments, only: [:create, :destroy]
  end 
end

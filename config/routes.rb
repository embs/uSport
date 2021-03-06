USport::Application.routes.draw do

  devise_for :users

  root to: "landing#index"

  resources :channels

  resources :user_channel_associations, only: :destroy

  resources :teams

  resources :players

  match :search, to: 'search#index', as: :search_index

  resources :users, only: [:index, :show, :edit, :update] do
    resources :favorite_channels, only: [:index, :create, :destroy]
  end

  resources :matches, except: :index do
    post :viewers, on: :member
    resources :moves, except: :show do
      match 'like' => 'moves#vote'
      resources :comments, only: [:index, :new, :create, :destroy]
    end
  end

  resources :authentications, :only => :create

  devise_scope :user do
    get "/login" => "devise/sessions#new"
    get "/logout" => "devise/sessions#destroy"
  end

  # Autenticação com Facebook
  match '/auth/:provider/callback' => 'authentications#create'

  # Rota para autenticação de presença do Pusher
  get '/pusher/auth' => 'matches#auth'
  post '/pusher/auth' => 'matches#auth'

  # Rota para página about, que explica o funcionamento do uSport
  get '/about' => 'landing#about'

  # Rotas para central de ajuda
  match 'help', to: 'help#index'
  match 'help/:topic(.:format)', to: 'help#topic'
end

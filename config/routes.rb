USport::Application.routes.draw do

  devise_for :users

  root to: "landing#index"

  resources :channels

  resources :user_channel_associations, only: :destroy

  resources :teams

  resources :players

  resources :users, only: [:index, :show, :edit, :update] do
    resources :favorite_channels, only: [:index, :create, :destroy]
  end

  resources :moves

  resources :matches, except: :index do
    post :viewers, on: :member
    resources :moves do
      match 'like' => 'moves#vote'
      resources :comments, :only => [:index, :new, :create]
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
end

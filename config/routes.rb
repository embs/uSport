USport::Application.routes.draw do

  devise_for :users

  root to: "landing#index"

  resources :channels do
    match 'remove_channel_cooperator/:id' => 'channels#remove_cooperator', as: "remove_cooperator"
  end

  resources :teams

  resources :players

  resources :users, only: [:index, :show, :edit, :update] do
    resources :favorite_channels, only: [:index, :create, :destroy]
  end

  resources :matches, except: :index do
    post :viewers, on: :member
    resources :moves do
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
end

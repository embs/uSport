USport::Application.routes.draw do

  devise_for :users

  root to: "landing#index"

  resources :channels

  resources :teams, :except => :index

  resources :players, :only => [:index, :new, :create, :show]

  resources :users, :only => [:index, :edit, :update] do
    resources :favorite_channels, only: [:index, :create, :destroy]
  end

  resources :moves do
    resources :comments, :only => [:index, :new, :create]
  end

  resources :matches, :except => [:index, :edit, :update]

  resources :authentications, :only => :create

  devise_scope :user do
    get "/login" => "devise/sessions#new"
    get "/logout" => "devise/sessions#destroy"
  end

  # Autenticação com Facebook
  match '/auth/:provider/callback' => 'authentications#create'

end

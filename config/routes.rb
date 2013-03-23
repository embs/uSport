USport::Application.routes.draw do

  devise_for :users

  root to: "landing#index"

  resources :channels

  resources :teams

  resources :players

  resources :users, :only => [:index, :edit, :update] do
    resources :favorite_channels, only: [:index, :create, :destroy]
  end

  resources :matches, except: :index do
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

end

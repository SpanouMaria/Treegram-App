Rails.application.routes.draw do
    get '/' => 'home#index'
  
    resources :users do
      member do
        post :follow
        delete :unfollow
      end
      resources :photos, only: [:index, :new, :create, :show, :destroy]
    end
  
    resources :photos, only: [:show, :destroy] do
      resources :comments, only: [:create, :destroy]   
      member do
        get :comments, as: :photo_comments
      end
    end
  
    resources :tags, only: [:create, :destroy]
  
    get '/log-in' => "sessions#new"
    post '/log-in' => "sessions#create"
    get '/log-out' => "sessions#destroy", as: :log_out
  end
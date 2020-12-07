Rails.application.routes.draw do
  devise_for :users
  root to: "cleanings#index"  
  resources :desks do
    resources :comments, only: :create
  end 
  resources :suggestions, only: [:index, :new, :create, :edit, :update, :destroy] do
    member do
      patch 'finish'
    end
    collection do
      get 'clean'
    end
  end
  resources :users, only: [:edit, :update]
  post '/callback' => 'linebot#callback'
end

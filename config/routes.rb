Rails.application.routes.draw do
  resources :suggestions, only: [:index, :new]
  devise_for :users
  root to: "cleanings#index"  
  resources :desks do
    resources :comments, only: :create
  end 
end

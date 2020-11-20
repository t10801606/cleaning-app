Rails.application.routes.draw do
  devise_for :users
  root to: "cleanings#index"  
  resources :desks do
    resources :comments, only: :create
  end 
  resources :suggestions, only: [:index, :new, :create, :edit, :update] do
    member do
      patch 'finish'
    end
  end
end

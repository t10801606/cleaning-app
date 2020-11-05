Rails.application.routes.draw do
  devise_for :users
  root to: "cleanings#index"  
  resources :desks, only: :index
end

Rails.application.routes.draw do
  get 'homes/about' => 'homes#about'
  root to: 'homes#top'
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update]
  resources :books do 
    resource :favorites, only: [:create, :destroy]
  end
 
end
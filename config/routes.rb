Rails.application.routes.draw do
  get 'homes/about' => 'homes#about'
  root to: 'homes#top'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
  }

  resources :users do
    resource :relationships, only: [:create, :destroy]
    get 'followeds' => 'users#followeds', as: 'followeds'
    get 'followers' => 'users#followers', as: 'followers'
  end

  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  get "search" => "searches#search"

end
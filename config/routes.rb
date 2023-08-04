Rails.application.routes.draw do

  root to: 'homes#top'

  devise_for :users
  get 'homes/about' => 'homes#about'
  get 'comments/create'
  get 'comments/destroy'
  resources :postimages, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    resources :comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:index,:show,:edit,:update] do
    get "search", to: "users#search"
    member do
      get :follows, :followers
    end
      resource :relationships, only: [:create, :destroy]
  end


# 管理者用
  namespace :admin do
    get '/' => 'homes#top'
    resources :postimages, only: [:index, :show, :edit, :update]
    resources :users, only: [:index, :show, :edit, :update]
  end
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

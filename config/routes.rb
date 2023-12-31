Rails.application.routes.draw do

  root to: 'public/homes#top'

# 顧客用
# URL /customers/sign_in ...
 devise_for :users,skip: [:passwords], controllers: {
   registrations: "public/registrations",
   sessions: 'public/sessions'
 }

 # 管理者用
 # URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

# 顧客用
scope module: :public do
  post 'homes/guest_sign_in', to: 'homes#guest_sign_in'
  get 'homes/about' => 'homes#about'
  get 'users/confirm' => 'users#confirm'
  get "search", to: 'searches#search'
  patch 'users/withdraw' => 'users#withdraw'
  resources :postimages, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    resources :comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:index,:show,:edit,:update] do
    member do
      get :follows, :followers
      get :favorites
    end
      resource :relationships, only: [:create, :destroy]
  end

end


# 管理者用
  namespace :admin do
    get '/' => 'homes#top'
    get "search", to: 'searches#search'
    resources :postimages, only: [:index, :show, :edit, :update, :destroy] do
      resources :comments, only: [:create, :destroy]
    end
    resources :users, only: [:index, :show, :edit, :update]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

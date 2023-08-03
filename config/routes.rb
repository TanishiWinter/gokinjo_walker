Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
  get 'comments/create'
  get 'comments/destroy'
  get 'postimages/new'
  get 'postimages/index'
  get 'postimages/create'
  get 'postimages/edit'
  get 'postimages/show'
  get 'postimages/update'
  get 'postimages/destroy'
  get 'homes/top'
  get 'homes/about'
  get 'users/index'
  get 'users/show'
  get 'users/edit'
  get 'users/update'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

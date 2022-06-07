Rails.application.routes.draw do
  #homeルート
  root "home#top"

  #userルート
  get "login" => "users#login_form"
  post "login" => "users#login"
  post "logout" => "users#logout"

  #postルート
  get "posts/new_category" => "posts#new_category"
  get "posts/search" => "posts#search"

  #いいねルート
  post 'like/:id' => 'likes#create', as: 'create_like'
  delete 'like/:id' => 'likes#destroy', as: 'destroy_like'

  resources:categories
  resources:users, except: [:index]
  resources:posts
end

Rails.application.routes.draw do
  get 'tweets/index'
  #homeルート
  root "home#top"

  #userルート
  get "login" => "users#login_form"
  post "login" => "users#login"
  post "logout" => "users#logout"

  #postルート
  get "posts/new_category" => "posts#new_category"

  #いいねルート
  post 'like/:id' => 'likes#create', as: 'create_like'
  delete 'like/:id' => 'likes#destroy', as: 'destroy_like'

  resources:tweets, except: [:show]
  resources:categories, except: [:show]
  resources:users, except: [:index]
  resources:posts, except: [:show]
end

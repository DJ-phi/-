Rails.application.routes.draw do
  root "home#top"

  get "login" => "users#login_form"
  post "login" => "users#login"
  post "logout" => "users#logout"
  post "posts/new_category" => "posts#new_category"

  resources:categories
  resources:users
  resources:posts
end

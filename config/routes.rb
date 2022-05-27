Rails.application.routes.draw do
  root "home#top"

  get "login" => "users#login_form"
  post "login" => "users#login"
  post "logout" => "users#logout"
  get "posts/new_category" => "posts#new_category"
  get "posts/search" => "posts#search"

  resources:categories
  resources:users
  resources:posts
end

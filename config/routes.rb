Rails.application.routes.draw do
  root "home#top"



  # get 'users/index'
  # post "users/:id/destroy" => "users#destroy"
  # post "users/create" => "users#create"
  resources:users
end

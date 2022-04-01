Rails.application.routes.draw do
  root "home#top"



  # get 'users/index'
  post "users/create" => "users#create"
  resources:users
end

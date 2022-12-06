Rails.application.routes.draw do

  #homeルート
  root "home#index"

  #userルート
  get "login" => "users#login_form"
  post "login" => "users#login"
  post "logout" => "users#logout"

  #postルート
  get "posts/new_category" => "posts#new_category"

  #いいねルート
  post 'post_like/:id' => 'post_likes#create', as: 'create_post_like'
  delete 'post_like/:id' => 'post_likes#destroy', as: 'destroy_post_like'

  # tweetのlike
  post 'tweet_like/:id' => 'tweet_likes#create', as: 'create_tweet_like'
  delete 'tweet_like/:id' => 'tweet_likes#destroy', as: 'destroy_tweet_like'

  # フォロー
  post 'follow/:id' => 'relationships#follow', as: 'follow' 
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' 

  resources:tweets, except: [:show]
  resources:categories, except: [:show]
  resources:users, except: [:index]
  resources:posts, except: [:show]
end

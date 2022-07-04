Rails.application.routes.draw do
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

  # tweetのlike
  post 'tweet_like/:id' => 'tweet_likes#create', as: 'create_tweet_like'
  delete 'tweet_like/:id' => 'tweet_likes#destroy', as: 'destroy_tweet_like'

  resources:tweets, except: [:show]
  resources:categories, except: [:show]
  resources:users, except: [:index]
  resources:posts, except: [:show]
end

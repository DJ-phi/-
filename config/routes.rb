Rails.application.routes.draw do

  #homeルート
  root "home#index"

  # ログイン処理を分ける前のルート
  # 現状は動いているがエラーになった場合いつでも使えるようにコメントアウト
  #userルート
  # get "login" => "users#login_form"
  # post "login" => "users#login"
  # post "logout" => "users#logout"

  get "login" => "sessions#new"
  post "login" => "sessions#create"
  post "logout" => "sessions#destroy"

  #postルート
  get "posts/new_category" => "posts#new_category"

  #いいねルート
  post 'post_like/:id' => 'post_likes#create', as: 'create_post_like'
  delete 'post_like/:id' => 'post_likes#destroy', as: 'destroy_post_like'

  # tweetのlike
  post 'tweet_like/:id' => 'tweet_likes#create', as: 'create_tweet_like'
  delete 'tweet_like/:id' => 'tweet_likes#destroy', as: 'destroy_tweet_like'

  # フォロー
  # post 'follow/:id' => 'relationships#create', as: 'follow' 
  # post 'unfollow/:id' => 'relationships#destroy', as: 'unfollow' 

  resources:tweets, except: [:show]
  resources:categories, except: [:show]
  resources:users, except: [:index] do
    member do
      get :following, :followers
    end
  end
  resources:posts, except: [:show]
  resources:relationships, only: [:create, :destroy]
end

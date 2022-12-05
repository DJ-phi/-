Rails.application.routes.draw do

  # "コントローラ名#メソッド名"
  #homeルート
  namespace :home do
    root "tops#top"
  end

  #userルート
  get "login" => "user_login#login_form"
  post "login" => "user_login#login"
  post "logout" => "user_login#logout"

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
  # TODO: 後ほど変更
  # postルート
  get "posts/new_category" => "new_category#new_category"
end

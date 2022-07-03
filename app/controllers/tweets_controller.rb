class TweetsController < ApplicationController
  # ruboで若干記述が変わっている
  # %iを入れることによって,が省略できている（多分）
  before_action :set_tweet, only: %i[edit update destroy] # findをメソッド化している

  # ログイン状態じゃないと見れないページ, application_controller.rbに記述がある
  before_action :authenticate_user

  # 正しいユーザーかを確かめるメソッド ログインしてるIDとひとしくないと編集できない様にしてる
  before_action :ensure_correct_tweet, only: %i[edit update destroy]

  def index
    @tweets = Tweet.all.order(created_at: :desc)
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    if @tweet.save
      flash[:notice] = "つぶやきました"
      redirect_to tweets_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @tweet.update(tweet_params)
      flash[:notice] = "更新しました"
      redirect_to tweets_path
    else
      render :edit
    end
  end

  def destroy
    @tweet.destroy
    flash[:notice] = "削除しました"
    redirect_to tweets_path
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:content, :user_id).merge(user_id: @current_user.id)
  end

  def ensure_correct_tweet
    return if @current_user.id == @tweet.user_id

    flash[:notice] = "権限がありません"
    redirect_to tweets_path
  end
end

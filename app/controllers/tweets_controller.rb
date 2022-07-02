class TweetsController < ApplicationController

  before_action :set_tweet, only: [ :edit, :update, :destroy ] #findをメソッド化している

  def index
    console
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

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:content, :user_id).merge(user_id: @current_user.id)
  end
end

class TweetLikesController < ApplicationController
  before_action :tweet_params

  def create
    TweetLike.create(user_id: @current_user.id, tweet_id: params[:id])
  end

  def destroy
    TweetLike.find_by(user_id: @current_user.id, tweet_id: params[:id]).destroy
  end

  private

  def tweet_params
    @tweet = Tweet.find(params[:id])
  end
end

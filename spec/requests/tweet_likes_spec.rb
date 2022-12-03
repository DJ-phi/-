require 'rails_helper'

RSpec.describe "TweetLikes", type: :request do
  let!(:user) { create(:user) }
  let!(:tweet) { create(:tweet) }

  before do
    login
  end

  describe "#tweet_likes" do
    it "データが作成されること" do
      expect do
        post "/tweet_like/#{tweet.id}.js"
      end.to change(TweetLike, :count).by(1)
    end
  end

  describe "#destroy" do
    let!(:tweet_like) { create(:tweet_like) }
    it "データが削除されること" do
      expect do
        delete "/tweet_like/#{tweet.id}.js"
      end.to change(TweetLike, :count).by(-1)
    end
  end
end

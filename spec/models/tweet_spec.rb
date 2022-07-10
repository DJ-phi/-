require 'rails_helper'

RSpec.describe Tweet, type: :model do
  before do
    create(:user)
  end
  let!(:tweet) { create(:tweet) }

  describe "バリデーション" do
    it "文字制限50文字以上" do
      tweet.content = "12345678910_12345678910_12345678910_12345678910_12345678910_12345678910_"
      expect(tweet.valid?).to eq(false)
    end

    it "空白だとNG" do
      tweet.content = ""
      expect(tweet.valid?).to eq(false)
    end
  end

  # TODO:未完成
  describe "モデルのオプションdependent: :destroyのテスト" do
    before do
      # create(:tweet_like)
    end
    it "tweetを消したらlikeも消えること" do
      # expect { tweet.destroy }.to change(TweetLike, :count).by(-1)
    end
  end
end

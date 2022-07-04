require 'rails_helper'

RSpec.describe Tweet, type: :model do
  let!(:user) { create(:user) }
  let!(:tweet) { create(:tweet) }
  let!(:tweet_like) { create(:tweet_like) }

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

  describe "モデルのオプションdependent: :destroyのテスト" do
    it "postを消したらlikeも消えること" do
      expect { post.destroy }.to change(TweetLike, :count).by(-1)
    end
  end
end

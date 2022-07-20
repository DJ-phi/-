require 'rails_helper'

RSpec.describe TweetLike, type: :model do
  let!(:user) { create(:user) }
  let!(:tweet) { create(:tweet) }

  describe '正常値と異常値の確認' do
    it "自分のtweetにlikeできる" do
      expect(TweetLike.new(user:, tweet:).save).to eq true
    end
  end
end

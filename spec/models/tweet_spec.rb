require 'rails_helper'

RSpec.describe Tweet, type: :model do
  let(:tweet) { create(:tweet) }

  before do
    create(:user)
  end

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
end

require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @user = create(:user)
    @category = create(:category)
    @post = create(:post)
  end

  describe "バリデーション" do
    it "[price]数字以外はバリデーションがかかること" do
      @post.price = ""
      expect(@post.valid?).to eq(false)
    end

    it "memoの20文字制限" do
      @post.memo = "123456789012345678902344"
      expect(@post.valid?).to eq(false)
    end
  end
end

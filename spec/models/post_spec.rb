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

  describe "スコープ" do
    it "keywordスコープで値が取れていること!!" do
      expect(Post.keyword("御飯")).to include(@post)
    end

    it "pricesスコープで値が取れている事" do
      expect(Post.prices(100)).to include(@post)
    end

      it "use_dayスコープで値が取れていること" do
        expect(Post.use_day("2022-06-01", "2022-06-02")).to include(@post)
      end
  end
end

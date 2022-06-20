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

  # TODO: 追加未完成
  describe "スコープ" do

    it "keywordスコープで値が取れていること!!" do
      expect(Post.keyword("御飯")).to include(@post)
    end

    it "完全一致検索" do
      expect(Post.prices(100)).to include(@post)
    end

    # TODO: 未完成
    #   it "間検索" do
    #     @post2 = build(:post, :find_post1)
    #     @post3 = build(:post, :find_post2)
    #     @post4 = build(:post, :find_post3)
    #     @posts = Post.use_day
    #     # items = Item.where(price: 15000..25000)
    #     expect(@posts.count).to eq 3
    #   end
  end
end

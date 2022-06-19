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

  # TODO:追加未完成
  # describe "検索機能" do
  #   let!(:post_attributes1) { attributes_for(:find_post, :find_post1) }
  #   let!(:post_attributes2) { attributes_for(:find_post, :find_post2) }
  #   let!(:post_attributes3) { attributes_for(:find_post, :find_post3) }
  #   let!(:post_new1) { create(:find_post, :find_post1)}
  #   let!(:post_new2) { create(:find_post, :find_post2)}
  #   let!(:post_new3) { create(:find_post, :find_post3)}

  #   it "曖昧検索" do
      
  #     expect(Post.).to include(post_attributes1)
  #   end

  #   it "完全一致検索" do
  #     expect(Post.prices(100)).to include(new_post)
  #   end

  #   it "間検索" do
      
  #   end
  # end
end

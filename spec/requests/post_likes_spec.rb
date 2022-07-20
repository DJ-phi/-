require 'rails_helper'

RSpec.describe "PostLikes", type: :request do
  let!(:user) { create(:user) }
  let!(:category) { create(:category) }
  let!(:new_post) { create(:post) }

  before do
    login
  end

  # 非同期はjsonを返すから.jsをつける必要があった
  describe "#create" do
    it "データが作成されること" do
      expect do
        post "/post_like/#{new_post.id}.js"
      end.to change(PostLike, :count).by(1)
    end
  end

  describe "#destroy" do
    let!(:post_like) { create(:post_like) }
    it "データが削除されること" do
      expect do
        delete "/post_like/#{new_post.id}.js"
      end.to change(PostLike, :count).by(-1)
    end
  end
end

require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let!(:new_post) { create(:post) }
  let!(:post_create) { attributes_for(:post) }
  let!(:user) { create(:user) }

  before do
    login
  end

  describe "GET /new" do
    before do
      get new_post_path
    end

    it "レスポンスステータスコードが200であること" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "#create" do
    context "有効なパラメーターの場合" do
      it "データが作成されること" do
        expect {
          post posts_path, params: { post: post_create  } #paramsはフォームで送られている情報
        }.to change(Post, :count).by(1)
      end
    end
  end

  describe "GET /show" do
    before do
      get post_path(new_post.id)
    end

    it "食事代が取得されていること" do
      expect(response.body).to include new_post.food.to_s
    end

    it "交通費が取得されていること" do
      expect(response.body).to include new_post.traffic.to_s
    end

    it "合計金額が取得されていること" do
      expect(response.body).to include new_post.total_price.to_s
    end

    it "使った日時が取得できていること" do
      expect(response.body).to include new_post.updated_at.to_s
    end

    it "レスポンスステータスコードが200であること" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    before do
      get edit_post_path(new_post.id)
    end

    it "食事代が取得されていること" do
      expect(response.body).to include new_post.food.to_s
    end

    it "交通費が取得されていること" do
      expect(response.body).to include new_post.traffic.to_s
    end

    it "レスポンスステータスコードが200であること" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "#update" do
    context "有効なパラメーターの場合" do
      before do
        login
      end
      it "データが更新されること" do
        patch post_path(new_post), params: { post: post_create }
        expect(new_post.reload.food).to eq new_post[:food]
      end

      it "更新したデータのshowにリダイレクトされること" do
        patch post_path(new_post), params: { post: post_create }
        new_post.reload
        expect(response).to redirect_to(user_path(user.id))
      end
    end
  end

  describe "#destroy" do
    it "データが削除されること" do
      expect {
        delete post_path(new_post)
      }.to change(Post, :count).by(-1)
    end

    it "userのshowにリダイレクトされること" do
      delete post_path(new_post)
      expect(response).to redirect_to(user_path(user.id))
    end
  end
end

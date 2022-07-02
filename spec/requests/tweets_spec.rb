require 'rails_helper'

RSpec.describe "Tweets", type: :request do
  describe "GET /index" do

    it "returns http success" do
      get "/tweets/index"
      expect(response).to have_http_status(:success)
    end

    it "contentが取得されていること" do

    end

    it "userの名前が取得できていること" do

    end
  end

  describe "#new" do
    it "returns http success" do
      get ""
      expect(response).to have_http_status(:success)
    end
  end

  describe "#create" do
    context "有効なパラメータの場合" do
      it "データが作成されること" do

      end

      it "データが作成されるとリダイレクト先にいけてること" do

      end
    end

    context "無効なパラメーターの場合" do
      it "データが作成されない" do

      end
    end
  end

  describe "#update" do
    context "有効なパラメータの場合" do
      it "データが作成されること" do

      end

      it "データが作成されるとリダイレクト先にいけてること" do

      end
    end

    context "無効なパラメーターの場合" do
      it "データが作成されない" do

      end
    end
  end

  describe "#show" do
    it "returns http success" do
      get ""
      expect(response).to have_http_status(:success)
    end

    it "contentが取得されていること" do

    end

    it "userの名前が取得できていること" do

    end
  end

  describe "#edit" do
    it "returns http success" do
      get ""
      expect(response).to have_http_status(:success)
    end

    it "contentが取得されていること" do

    end

    it "userの名前が取得できていること" do

    end
  end

  describe "#destroy" do
    it "データが削除されること" do

    end
  end

  describe "アクセス制限" do
    context "ログインしている場合" do
      it "編集ページで、ログインidと違うidの場合、リダイレクトされること" do
        # edit
      end
    end

    context "ログインしていない場合" do
      it "tweetページにいくとれダイレクトされること" do

      end
    end
  end
end

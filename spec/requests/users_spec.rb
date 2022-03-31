require 'rails_helper'

RSpec.describe "Users", type: :request do

  before do
    # get "/users/index"
    get users_path(user.id)
  end
  describe "GET /index" do

    it "使ったお金が取得されている" do
    end

    it "食事代が取得されていること" do

    end

    it "交通費が取得されていること" do

    end

    it "合計金額が取得されていること" do

    end

    it "使った日時が取得できていること" do

    end

    it "レスポンスステータスコードが200であること" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do

  it "" do
  end
    it "レスポンスステータスコードが200であること" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do

    it "名前が取得できていること" do

    end

    it "パスワードが取得できていること" do

    end

    it "レスポンスステータスコードが200であること" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do

    

    it "レスポンスステータスコードが200であること" do
      expect(response).to have_http_status(:success)
    end
  end
end

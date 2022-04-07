require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:user) { create(:user) }
  let!(:post) { create(:post) }
  
  before do
    get users_path #２つ入れると何故かテストが通る
    get users_path
    get new_user_path
    # get users_path(user.id) 使うかもしれないからとりあえず保留
    # get edit_user_path こいつ入れるとActionController::UrlGenerationError:が出てくる
  end

  describe "#index" do
    # it "食事代が取得されていること" do
    #   expect(response.body).to include post.food
    # end

    # it "交通費が取得されていること" do
    #   expect(response.body).to include post.traffic
    # end

    # it "合計金額が取得されていること" do
    #   expect(response.body).to include post.count_price
    # end

    # it "使った日時が取得できていること" do
    #   expect(response.body).to include post.use_day
    # end

    it "ユーザーの名前が取得できていること" do
      expect(response.body).to include user.name
    end

    it "レスポンスステータスコードが200であること" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "#new" do
    it "レスポンスステータスコードが200であること" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "#create" do

  end

  describe "#show" do
    it "名前が取得できていること" do
      expect(response.body).to include user.name
    end
binding.pry
    it "emailが取得されていること" do
      expect(response.body).to include user.email
    end

    it "パスワードが取得できていること" do
      expect(response.body).to include user.password.to_s
    end

    it "レスポンスステータスコードが200であること" do
      expect(response).to have_http_status(:success)
    end
  end

  # describe "#edit" do
  #   it "名前が取得できていること" do
  #     expect(response.body).to include user.name
  #   end

  # it "emailが取得されていること" do
  #   expect(response.body).to include user.email
  # end

  #   it "パスワードが取得できていること" do
  #     expect(response.body).to include user.password
  #   end

  #   it "レスポンスステータスコードが200であること" do
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  describe "#update" do

  end

  describe "#destroy" do
    
  end
end

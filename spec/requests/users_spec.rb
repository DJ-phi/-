require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:user) { create(:user) }
  let!(:new_post) { create(:post) }
  
  before do
    # get users_path 
    # get new_user_path
    # get users_path(user.id) 
    # @user = FactoryBot.create(:user)
    # session_params = { session: { email: user.email, password: user.password } }
      # post "/login", params: session_params
      # binding.pry
  end

  describe "#index" do

    before do
      # post "/login", params: session_params
      # get users_path 
      # binding.pry
    end

    it "ユーザーの名前が取得できていること" do
      session_params = { session: { email: user.email, password: user.password } }
        post "/login", params: session_params
      get users_path 
      binding.pry
      expect(response.body).to include user.name
    end

    it "レスポンスステータスコードが200であること" do
      expect(response).to have_http_status(:success)
    end

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
  end

  describe "#new" do

    before do
      get new_user_path
    end

    it "レスポンスステータスコードが200であること" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "#create" do

  end

  describe "#show" do

    before do
      get users_path(user.id) 
    end

    it "名前が取得できていること" do
      expect(response.body).to include user.name
    end

    it "emailが取得されていること" do
      expect(response.body).to include user.email
    end

    # it "パスワードが取得できていること" do
    #   expect(response.body).to include user.password.to_s
    # end

    it "レスポンスステータスコードが200であること" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "#edit" do

    before do
      get users_path(user.id) 
    end

    it "名前が取得できていること" do
      expect(response.body).to include user.name
    end

  it "emailが取得されていること" do
    expect(response.body).to include user.email
  end

    # it "パスワードが取得できていること" do
    #   expect(response.body).to include user.password.to_s
    # end

    it "レスポンスステータスコードが200であること" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "#update" do

  end

  describe "#destroy" do
    
  end
end

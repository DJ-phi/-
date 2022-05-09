require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:user) { create(:user) }
  let!(:new_post) { create(:post) }
  let!(:valid_attributes) { attributes_for(:user, :for_create) } #attributes_forはフォームに入力したい情報を作ってる
  let!(:new_valid_attributes) { attributes_for(:user, :for_update) }
  let!(:unvalid_attributes) { attributes_for(:user, :un_update) }

  describe "#index" do
    before do
      login
      get users_path

    end

    it "ユーザーの名前が取得できていること" do
      expect(response.body).to include user.name
    end

    it "レスポンスステータスコードが200であること" do
      expect(response).to have_http_status(:success)
    end
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
    context "有効なパラメーターの場合" do
      it "データが作成されること" do
        expect {
          post users_path, params: { user: valid_attributes  } #paramsはフォームで送られている情報
        }.to change(User, :count).by(1)
      end
    end
  end

  describe "#show" do
    before do
      login
      get user_path(user.id) 
    end

    it "名前が取得できていること" do
      expect(response.body).to include user.name
    end

    it "emailが取得されていること" do
      expect(response.body).to include user.email
    end

    it "パスワードが取得できていること" do
      expect(response.body).to include user.password.to_s
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
      expect(response.body).to include new_post.created_at.strftime('%Y/%m/%d')
    end

    it "レスポンスステータスコードが200であること" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "#edit" do
    before do
      login
      get edit_user_path(user.id) 
    end

    it "名前が取得できていること" do
      expect(response.body).to include user.name
    end

  it "emailが取得されていること" do
    expect(response.body).to include user.email
  end

    it "レスポンスステータスコードが200であること" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "#update" do
    before do
      login
    end

    context "有効なパラメーターの場合" do
      it "データが更新されること" do
        patch user_path(user), params: { user: new_valid_attributes }
        expect(user.reload.name).to eq new_valid_attributes[:name]
      end

      it "更新したデータのshowにリダイレクトされること" do
        patch user_path(user), params: { user: new_valid_attributes }
        user.reload
        expect(response).to redirect_to(user_path(user))
      end
    end

    context "無効なパラメーターの場合" do
      it "レスポンスが200であること" do
        patch user_path(user), params: { user: unvalid_attributes }
        expect(response.status).to eq 200
      end
    end
  end

  describe "#destroy" do
    it "データが削除されること" do
      expect {
        delete user_path(user)
      }.to change(User, :count).by(-1)
    end

    it "indexにリダイレクトされること" do
      delete user_path(user)
      expect(response).to redirect_to(users_path)
    end
  end
  
  describe "アクセス制限" do
    context "ログインしている場合" do
      before do
        login
      end

      it "新規作成ページにいけないようになっていること" do
        get new_user_path
        expect(response).to_not have_http_status(:success)
      end

      it "アクセス制限された場合一覧ページにリダイレクトされていること" do
        get new_user_path
        expect(response).to redirect_to(users_path)
      end
    end

    context"ログインしていない場合" do
      it "一覧ページにいけないようになっていること" do
        get users_path
        expect(response).to_not have_http_status(:success)
      end

      it "一覧ページにいくとログインページにリダイレクトされること" do
        get users_path
        expect(response).to redirect_to(login_path)
      end
    end
  end
end

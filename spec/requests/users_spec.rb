require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:user) { create(:user) }
  let!(:user2) { create(:user, :for_ensure_correct) }

  #attributes_forはフォームに入力したい情報を作ってる
  #ハッシュになる
  #例, 中身post :create, params: { post: {:name=>"test", :email=>"test2@test.com", :password=>"password"} }
  let!(:valid_attributes) { attributes_for(:user, :for_create) } 
  let!(:new_valid_attributes) { attributes_for(:user, :for_update) }
  let!(:unvalid_attributes) { attributes_for(:user, :un_update) }

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
      # userを作成するとcategoryが一つ生成される仕様のため
      it "categoryのデータが生成される" do
        expect {
          post users_path, params: { user: valid_attributes } #paramsはフォームで送られている情報
        }.to change(Category, :count).by(1)
      end
      
      it "データが作成されること" do
        expect {
          post users_path, params: { user: valid_attributes } #paramsはフォームで送られている情報
        }.to change(User, :count).by(1)
      end

      it "データが作成されるとshowにリダイレクトされること" do
        post users_path, params: { user: valid_attributes } #paramsはフォームで送られている情報
        expect(response).to redirect_to(user_path(User.last)) #User.lastにしないと通らないUser.lastは一番新しく作ったデータを参照
      end
    end

    context "無効なパラメーターの場合" do
      #createの場合postになる
      it "レスポンスが200であること" do
        post users_path, params: { user: unvalid_attributes }
        expect(response.status).to eq 200
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
      #patchはupdate
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
    before do
      login
    end
    
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

      it "制限されたページにいくとshowリダイレクトされていること" do
        get new_user_path
        expect(response).to redirect_to(user_path(user))
      end

      it "ログインユーザー以外の編集ページにいくとshowリダイレクトされていること" do
        get edit_user_path(2)
        expect(response).to redirect_to(user_path(user))
      end

      it "indexに行けないこと" do
        # TODO: 後ほど
      end
    end

    context"ログインしていない場合" do
      it "制限にかかったページにいくとログインページにリダイレクトされること" do
        get posts_path
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe "ログイン" do
    context "有効なパラメータの場合" do
      it "ログインに成功したらuser/showにリダイレクトされること" do
        login
        expect(response).to redirect_to(user_path(user))
      end
    end

    context "無効なパラメータな場合" do
      it "レスポンスステータスコードが200であること" do
        login_params = { email: "", password: "" }
        post login_path, params: login_params
        expect(response.status).to eq 200
      end
    end
  end

  # TODO: テスト未完成
  describe "ログアウト" do
    it "ログアウトに成功したら" do
      login
      delete logout_path
      expect(response).to redirect_to(login_path)
    end
  end
end

require 'rails_helper'

RSpec.describe "Categories", type: :request do
  let!(:user) { create(:user) }
  let!(:user2) { create(:user, :for_ensure_correct) }
  let!(:category) { create(:category) }
  let!(:category2) { create(:category, :for_ensure_correct) }
  #attributes_forはフォームに入力したい情報を作ってる
  #ハッシュになる
  #例, 中身post :create, params: { post: {:name=>"test", :email=>"test2@test.com", :password=>"password"} }
  let!(:valid_attributes) { attributes_for(:category, :for_update) }
  let!(:new_valid_attributes) { attributes_for(:category, :for_create) }
  let!(:unvalid_attributes) { attributes_for(:category, :un_update) }
  #                                             ↑ここを変え忘れると違うテーブルのデータが生成される

  describe "#index" do
    before do
      login
      get categories_path
    end

    it"nameが表示されている" do
      expect(response.body).to include category.name
    end

    it "レスポンスステータスコードが正常である" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "#new" do
    before do
      login
      get new_category_path
    end

    it "レスポンスステータスコードが200であること" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "#create" do
    before do
      login
    end

    context "有効なパラメーターの場合" do
      it "データが作成されること" do
        expect {
          post categories_path, params: { category: valid_attributes } #paramsはフォームで送られている情報
        }.to change(Category, :count).by(1)
      end

      it "データが作成されるとposts/indexにリダイレクトすること" do
        post categories_path, params: { category: valid_attributes } #paramsはフォームで送られている情報
        expect(response).to redirect_to(categories_path)
      end
    end

    context "無効なパラメーターの場合" do
      it "レスポンスが200であること" do
        post categories_path, params: { category: unvalid_attributes }
        expect(response.status).to eq 200
      end
    end
  end

  describe "#edit" do
    before do
      login
      get edit_category_path(category.id)
    end

    it "nameが取得できている" do
      expect(response.body).to include category.name
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
        patch category_path(category), params: { category: new_valid_attributes }
        expect(category.reload.name).to eq category[:name]
      end

      it "更新したデータのindexにリダイレクトされること" do
        patch category_path(category), params: {category: new_valid_attributes }
        category.reload
        expect(response).to redirect_to(categories_path)
      end
    end

    context "無効なパラメーターの場合" do
      it "レスポンスが200であること" do
        patch category_path(category), params: { category: unvalid_attributes }
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
        delete category_path(category)
      }.to change(Category, :count).by(-1)
    end

    it "categories/indexにリダイレクトされること" do
      delete category_path(category)
      expect(response).to redirect_to(categories_path)
    end
  end

  describe "アクセス制限" do 
    context"ログインしている場合" do
      it "ログインユーザーじゃない編集ページにいくとリダイレクトされること" do
        login
        get edit_category_path(2)
        expect(response).to redirect_to(categories_path)
      end

      # shoeを実装していないから
      it "categoryのshowに行けないこと" do
        login
        expect do
          get category_path(category)
        end.to raise_error(ActionController::RoutingError)
      end
    end

    context"ログインしていない場合" do
      it "制限のかかっているページににいくとログインページにリダイレクトされること" do
        get new_category_path
        expect(response).to redirect_to(login_path)
      end
    end
  end
end

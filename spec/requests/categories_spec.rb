require 'rails_helper'

RSpec.describe "Categories", type: :request do
  let!(:user) { create(:user) }
  let!(:category) { create(:category) }
  let!(:category_create) { attributes_for(:category) }

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
          post categories_path, params: { category: category_create } #paramsはフォームで送られている情報
        }.to change(Category, :count).by(1)
      end

      it "データが作成されるとposts/indexにリダイレクトすること" do
        post categories_path, params: { post: post_create } #paramsはフォームで送られている情報
        expect(response).to redirect_to(categories_path)
      end
    end

    context "無効なパラメーターの場合" do
      it "レスポンスが200であること" do
        patch user_path(user), params: { user: unvalid_attributes }
        expect(response.status).to eq 200
      end
    end
  end

  describe "#show" do
    before do
      login
      get category_path(category.id)
    end

    it "nameが表示されている" do
      expect(response.body).to include category.name
    end

    it "レスポンスステータスコードが200であること" do
      expect(response).to have_http_status(:success)
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
        patch category_path(category), params: { category: category_create }
        expect(category.reload.name).to eq category[:name]
      end

      it "更新したデータのshowにリダイレクトされること" do
        patch category_path(category), params: {category: category_create }
        category.reload
        expect(response).to redirect_to(categories_path)
      end
    end

    # context "無効なパラメーターの場合" do
    #   it "レスポンスが200であること" do
    #     patch user_path(user), params: { user: unvalid_attributes }
    #     expect(response.status).to eq 200
    #   end
    # end
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
    context"ログインしていない場合" do
      it "new_category_pathにいけないようになっていること" do
        get new_category_path
        expect(response).to_not have_http_status(:success)
      end

      it "edit_category_pathにいけないようになっていること" do
        get edit_category_path(category.id)
        expect(response).to_not have_http_status(:success)
      end

      it "categoryのshowにいけないようになっていること" do
        get category_path(category.id)
        expect(response).to_not have_http_status(:success)
      end

      it "制限のかかっているページににいくとログインページにリダイレクトされること" do
        get new_category_path
        expect(response).to redirect_to(login_path)
      end
    end
  end
end

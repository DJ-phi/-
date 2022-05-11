require 'rails_helper'

RSpec.describe "Categories", type: :request do
  let!(:user) { create(:user) }
  let!(:category) { create(:category) }

  describe "#index" do

    it"nameが表示されている" do
      expect(response.body).to include category.name
      expect(response.body).to include user.name
    end

    it "レスポンスステータスコードが正常である" do
      get "/categories/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
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
          post categries_path, params: { post: category  } #paramsはフォームで送られている情報
        }.to change(Category, :count).by(1)
      end
    end
  end

  describe "GET /show" do
    before do
      login
      get category_path(new_category.id)
    end

    it "nameが表示されている" do
      expect(response.body).to include category.name
    end

    it "レスポンスステータスコードが200であること" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
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
        patch category_path(category), params: { post: category }
        expect(category.reload.name).to eq category[:name]
      end

      it "更新したデータのshowにリダイレクトされること" do
        patch post_path(category), params: { post: category }
        category.reload
        # expect(response).to redirect_to(user_path(user.id))
      end
    end
  end

  describe "#destroy" do
    before do
      login
    end

    it "データが削除されること" do
      expect {
        delete post_path(category)
      }.to change(Category, :count).by(-1)
    end

    # it "userのshowにリダイレクトされること" do
    #   delete post_path(category)
    #   expect(response).to redirect_to(user_path(user.id))
    # end
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

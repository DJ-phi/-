require 'rails_helper'

RSpec.describe "Posts", type: :request do

  #アソシエーションしていると外部キーがないとダメな為他のテーブルも作る必要がある
  #先にuserを作らないとバリデーションエラーになる
  #categoryはuserがないと作れないため先にuserを作る,postはuserとcategoryを作らないといけないためこの順番になる
  #user→categry→post
  let!(:user) { create(:user) }
  let!(:category) { create(:category) }
  let!(:new_post) { create(:post) }

  #attributes_forはフォームに入力したい情報を作ってる
  #ハッシュになる
  #例, 中身post :create, params: { post: {:name=>"test", :email=>"test2@test.com", :password=>"password"} }
  let!(:valid_attributes) { attributes_for(:post, :for_update) }
  let!(:new_valid_attributes) { attributes_for(:post, :for_create) }
  let!(:unvalid_attributes) { attributes_for(:post, :un_update) }

  describe "GET /index" do
    before do
      login
      get posts_path
    end

    it "値段が取得できている" do
      expect(response.body).to include new_post.price.to_s
    end

    it "メモが取得できている" do
      expect(response.body).to include new_post.memo
    end

    it "画像が取得ができている" do
      expect(response.body).to include url_for(new_post.image)
    end

    it "使った日が取得できている" do
      expect(response.body).to include new_post.use_day.to_s
    end

    it "カテゴリが取得できている" do
      expect(response.body).to include new_post.category.name
    end

    it "レスポンスステータスコードが200であること" do
      expect(response).to have_http_status(:success)
    end
  end

  # TODO追加未完成
  describe "検索機能" do
    let!(:post_attributes1) { attributes_for(:post, :form_post1) }
    let!(:post_attributes2) { attributes_for(:post, :form_post2) }
    let!(:post_attributes3) { attributes_for(:post, :form_post3) }
    let!(:test_post1) { create(:post, :test_post1) }
    let!(:test_post2) { create(:post, :test_post2) }
    let!(:test_post3) { create(:post, :test_post3) }

    before do
      login
    end

    it "曖昧検索" do
      get posts_path(post_attributes1)
      expect(response.body).to include test_post1.memo
      expect(response.body).to_not include test_post2.memo
      expect(response.body).to_not include test_post3.memo
    end

    it "完全一致検索" do
      get posts_path(post_attributes2)
      expect(response.body).to include test_post2.price.to_s
      # TODO:後ほど削除
      # expect(response.body).to include test_post1.price.to_s
      # expect(response.body).to_not include test_post3.price.to_s
    end

    it "間検索" do
      # 上のletでレコード3件作成, post_attributes3で2件取得できるフォームを作っているので
      # includeは2であればok
      get posts_path(post_attributes3)
      expect(response.body).to include "投稿数" + ""
    end
  end

  # ここのテストはloginの後にcreateの処理をしないとレコードが作成されない
  # なので上のテストと分ける必要があった
  describe "#indexの合計" do
    it "レコードの数を取得できている" do
      login
      Post.create(user_id: 1, category_id: 1, price: 0)
      get posts_path
      expect(response.body).to include "投稿数#{Post.count}"
    end

    it "値段の合計ができている" do
      login
      Post.create(user_id: 1, category_id: 1, price: 100)
      get posts_path
      expect(response.body).to include "合計金額¥#{Post.all.map(&:price).sum}"
    end
  end

  describe "GET /new" do
    before do
      login
      get new_post_path
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
          post posts_path, params: { post: new_valid_attributes } #paramsはフォームで送られている情報
        }.to change(Post, :count).by(1)
      end

      it "データが作成されるとposts/indexにリダイレクトすること" do
        post posts_path, params: { post: new_valid_attributes } #paramsはフォームで送られている情報
        expect(response).to redirect_to(posts_path)
      end
    end

    context "無効なパラメーターの場合" do
      it "レスポンスが200であること" do
        post posts_path, params: { post: unvalid_attributes }
        expect(response.status).to eq 200
      end
    end
  end

  describe "GET /edit" do
    before do
      login
      get edit_post_path(new_post.id)
    end

    it "値段が取得できている" do
      expect(response.body).to include new_post.price.to_s
    end

    it "メモが取得できている" do
      expect(response.body).to include new_post.memo
    end

    it "使った日が取得できている" do
      expect(response.body).to include new_post.use_day.to_s
    end

    it "カテゴリが取得できている" do
      expect(response.body).to include new_post.category.name
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
        patch post_path(new_post), params: { post: valid_attributes }
        expect(new_post.reload.memo).to eq new_post[:memo]
      end

      it "updateしたらindexにリダイレクトされること" do
        patch post_path(new_post), params: { post: valid_attributes }
        new_post.reload
        expect(response).to redirect_to(posts_path)
      end
    end

    context "無効なパラメーターの場合" do
      it "レスポンスが200であること" do
        patch post_path(new_post), params: { post: unvalid_attributes }
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
        delete post_path(new_post)
      }.to change(Post, :count).by(-1)
    end

    it "posts/indexにリダイレクトされること" do
      delete post_path(new_post)
      expect(response).to redirect_to(posts_path)
    end
  end

  describe "アクセス制限" do 
    let!(:user2) { create(:user, :for_ensure_correct) }
    let!(:category2) { create(:category, :for_ensure_correct) }
    let!(:new_post2) { create(:post, :for_ensure_correct) }
    context"ログインしている場合" do
      it "ログインユーザーじゃない編集ページにいくとリダイレクトされること" do
        login
        get edit_post_path(2)
        expect(response).to redirect_to(posts_path)
      end
    end

    context"ログインしていない場合" do
      it "ログインページにリダイレクトされること" do
        get new_post_path
        expect(response).to redirect_to(login_path)
      end
    end
  end
end

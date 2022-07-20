require 'rails_helper'

RSpec.describe "Tweets", type: :request do
  let!(:user) { create(:user) }
  let!(:user2) { create(:user, :for_ensure_correct) }
  let!(:tweet) { create(:tweet) }
  let!(:tweet2) { create(:tweet, :for_ensure_correct) }

  let!(:valid_attributes) { attributes_for(:tweet, :for_update) }
  let!(:new_valid_attributes) { attributes_for(:tweet, :for_create) }
  let!(:unvalid_attributes) { attributes_for(:tweet, :un_update) }

  describe "index" do
    before do
      login
      get tweets_path
    end

    it "レスポンスステータスコードが正常であること" do
      expect(response).to have_http_status(:success)
    end

    it "contentが取得されていること" do
      expect(response.body).to include tweet.content
    end

    it "userの名前が取得できていること" do
      expect(response.body).to include user.name
    end
  end

  describe "#new" do
    it "レスポンスステータスコードが正常であること" do
      login
      get new_tweet_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "#create" do
    before do
      login
    end

    context "有効なパラメータの場合" do
      # 何故かここは{}じゃなくdo,endの作りにされた(rubo)
      it "データが作成されること" do
        expect do
          post tweets_path, params: { tweet: new_valid_attributes } # paramsはフォームで送られている情報
        end.to change(Tweet, :count).by(1)
      end

      it "データが作成されるとリダイレクト先にいけてること" do
        post tweets_path, params: { tweet: new_valid_attributes }
        expect(response).to redirect_to(tweets_path)
      end
    end

    context "無効なパラメーターの場合" do
      it "データが作成されない" do
        post tweets_path, params: { tweet: unvalid_attributes }
        expect(response.status).to eq 200
      end
    end
  end

  describe "#update" do
    before do
      login
    end

    context "有効なパラメータの場合" do
      it "データが更新されること" do
        patch tweet_path(tweet), params: { tweet: valid_attributes }
        expect(tweet.reload.content).to eq tweet[:content]
      end

      it "データが作成されるとリダイレクト先にいけてること" do
        patch tweet_path(tweet), params: { tweet: valid_attributes }
        expect(response).to redirect_to(tweets_path)
      end
    end

    context "無効なパラメーターの場合" do
      it "データが作成されない" do
        patch tweet_path(tweet), params: { tweet: unvalid_attributes }
        expect(response.status).to eq 200
      end
    end
  end

  describe "#edit" do
    before do
      login
      get edit_tweet_path(tweet)
    end

    it "レスポンスステータスコードが正常であること" do
      expect(response).to have_http_status(:success)
    end

    it "contentが取得されていること" do
      expect(response.body).to include tweet.content
    end

    it "userの名前が取得できていること" do
      expect(response.body).to include user.name
    end
  end

  describe "#destroy" do
    before do
      login
    end

    it "データが削除されること" do
      expect do
        delete tweet_path(tweet)
      end.to change(Tweet, :count).by(-1)
    end

    it "tweets/indexにリダイレクトされること" do
      delete tweet_path(tweet)
      expect(response).to redirect_to(tweets_path)
    end
  end

  describe "アクセス制限" do
    context "ログインしている場合" do
      it "編集ページで、ログインidと違うidの場合、リダイレクトされること" do
        login
        get edit_tweet_path(2)
        expect(response).to redirect_to(tweets_path)
      end

      # showを実装していないから
      it "tweetのshowに行けないこと" do
        login
        expect do
          get tweet_path(tweet)
        end.to raise_error(ActionController::RoutingError)
      end
    end

    context "ログインしていない場合" do
      it "tweetページにいくとリダイレクトされること" do
        get tweets_path
        expect(response).to redirect_to(login_path)
      end
    end
  end
end

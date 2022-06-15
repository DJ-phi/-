require 'rails_helper'

RSpec.describe "Likes", type: :request do
  let!(:user) { create(:user) }
  let!(:category) { create(:category) }
  let!(:new_post) { create(:post) }
  let!(:like) { create(:like) }
  let!(:valid_attributes) { attributes_for(:like) }

  before do
    login
  end

  #TODO: 終わってない
  describe "#create" do
    it "データが作成されること" do
      expect do
        post create_like_path(new_post), params: { like: valid_attributes } # paramsはフォームで送られている情報
      end.to change(Like, :count).by(1)
    end
  end

  describe "#destroy" do
    it "データが削除されること" do
      expect do
        delete post_path(new_post)
      end.to change(Like, :count).by(-1)
    end
  end
end

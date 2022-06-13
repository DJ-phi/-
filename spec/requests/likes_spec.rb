require 'rails_helper'

RSpec.describe "Likes", type: :request do
  let!(:user) { create(:user) }
  let!(:category) { create(:category)}
  let!(:new_post) { create(:post) }
  let!(:like) { create(:like)}
  let!(:valid_attributes) { attributes_for(:like) }

  before do
    login
  end
  
  describe "#create" do
    it "データが作成されること" do
      expect {
        patch post_path(new_post), params: { like: valid_attributes } #paramsはフォームで送られている情報
      }.to change(Like, :count).by(1)
    end
  end

  describe "#destroy" do
    it "データが削除されること" do
      expect {
        delete post_path(new_post)
      }.to change(Like, :count).by(-1)
    end
  end
end

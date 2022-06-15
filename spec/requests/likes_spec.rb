require 'rails_helper'

RSpec.describe "Likes", type: :request do
  let!(:user) { create(:user) }
  let!(:category) { create(:category) }
  let!(:new_post) { create(:post) }
  let!(:valid_attributes) { attributes_for(:like) }

  before do
    login
  end

  #TODO: 終わってない
  #非同期はjsonを返すから.jsをつける必要があった
  describe "#create" do
    it "データが作成されること" do
      expect do
        post "/like/#{new_post.id}.js"
      end.to change(Like, :count).by(1)
    end
  end

  describe "#destroy" do
    let!(:like) { create(:like) }
    it "データが削除されること" do
      expect do
        delete "/like/#{new_post.id}.js"
      end.to change(Like, :count).by(-1)
    end
  end
end

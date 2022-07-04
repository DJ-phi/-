# require 'rails_helper'

# RSpec.describe "TweetLikes", type: :request do
#   let!(:user) { create(:user) }
#   let!(:category) { create(:category) }
#   let!(:new_post) { create(:post) }
#   let!(:valid_attributes) { attributes_for(:tweet_like) }

#   before do
#     login
#   end

#   describe "#tweet_likes" do
#     it "データが作成されること" do
#       expect do
#         post "/tweet_like/#{new_post.id}.js"
#       end.to change(TweetLike, :count).by(1)
#     end
#   end

#   describe "#destroy" do
#     let!(:like) { create(:like) }
#     it "データが削除されること" do
#       expect do
#         delete "/tweet_like/#{new_post.id}.js"
#       end.to change(TweetLike, :count).by(-1)
#     end
#   end
# end

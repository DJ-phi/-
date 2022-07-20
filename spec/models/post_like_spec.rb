require 'rails_helper'

RSpec.describe PostLike, type: :model do
  let!(:user) { create(:user) }
  let!(:category) { create(:category) }
  let!(:post) { create(:post) }

  describe '正常値と異常値の確認' do
    it "自分のpostにlikeできる" do
      expect(PostLike.new(user:, post:).save).to eq true
    end
  end
end

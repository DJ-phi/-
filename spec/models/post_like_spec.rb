require 'rails_helper'

RSpec.describe PostLike, type: :model do
  let(:post_like) { create(:post_like) }

  before do
    create(:user)
    create(:category)
    create(:post)
  end

  describe '正常値と異常値の確認' do
    it "user_idとpost_idがあれば保存できる" do
      expect(create(:post_like)).to be_valid
    end
  end
end

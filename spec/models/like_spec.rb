require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:like) { create(:like) }

  before do
    create(:user)
    create(:category)
    create(:post)
  end

  describe '正常値と異常値の確認' do
    it "user_idとpost_idがあれば保存できる" do
      expect(create(:like)).to be_valid
    end
  end
end

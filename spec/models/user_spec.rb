require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }

  describe "バリデーション" do
    it "名前とemail, passwordの値が設定されていれば、OK" do
      expect(user.valid?).to eq(true)
    end

    it "nameが被っていたらNG" do
      user.save
      user2 = build(:user)
      user2.name = user.name
      expect(user2.valid?).to eq(false)
    end

    it "nameの10文字制限" do
      user.name = "1234567891234"
      expect(user.valid?).to eq(false)
    end

    it "nameが空だとNG" do
      user.name = ""
      expect(user.valid?).to eq(false)
    end

    it "emailが空だとNG" do
      user.email = ""
      expect(user.valid?).to eq(false)
    end

    it "emailが重複しているとNG" do
      # mここでセーブしないと重複したデータが作れない
      user.save
      user2 = build(:user)
      user2.email = user.email
      expect(user2.valid?).to eq(false)
    end

    it "passwordが空だとNG" do
      user.password = ""
      expect(user.valid?).to eq(false)
    end

    it"passwordが4文字以下だったらNG" do
      user.password = "123"
      expect(user.valid?).to eq(false)
    end

    it"passwordが10文字以上だったらNG" do
      user.password = "1234567891011"
      expect(user.valid?).to eq(false)
    end
  end

  describe "モデルのオプションdependent: :destroyのテスト" do
    it "userを消したらpostも消えること" do
      category = create(:category)
      post = create(:post)
      user.destroy
      expect(Post.first).to eq(nil)
    end
  end
end

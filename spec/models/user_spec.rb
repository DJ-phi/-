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
    before do
      create(:category)
      create(:post)
      create(:like)
      #パターン2
      # _始まりの変数名は使わない変数であることを示す慣習みたいなものです。なお参照ができないわけではないです
      # _category = create(:category)
      # _post = create(:post)
      # _like = create(:like)
    end
    
    it "userを消したらpostも消えること" do
      expect { user.destroy }.to change(Post, :count).by(-1)
    end

    it "userを消したらcategoryも消えること" do
      expect { user.destroy }.to change(Category, :count).by(-1)
    end

    it "userを消したらlikeも消えること" do
      expect { user.destroy }.to change(Like, :count).by(-1)
    end
  end
end

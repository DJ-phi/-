require 'rails_helper'

RSpec.describe Category, type: :model do
  before do
    create(:user)
  end

  let!(:category) { create(:category) }

  describe "バリデーション" do
    it "[name]空だったらNG" do
      category.name = ""
      expect(category.valid?).to eq(false)
    end

    it "nameの20文字制限" do
      category.name = "12334447463862863874973497436"
      expect(category.valid?).to eq(false)
    end
  end

  describe "モデルのオプションdependent: :destroyのテスト" do
    before do
      create(:post)
    end

    it "categoryを消したらpostも消えること" do
      expect { category.destroy }.to change(Post, :count).by(-1)
    end
  end
end

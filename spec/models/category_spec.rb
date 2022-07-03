require 'rails_helper'

RSpec.describe Category, type: :model do
  let!(:user) { create(:user) }
  let!(:category) { create(:category) }
  let!(:post) { create(:post)}

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
    it "categoryを消したらpostも消えること" do
      expect { category.destroy }.to change(Post, :count).by(-1)
    end
  end
end

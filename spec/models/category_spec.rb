require 'rails_helper'

RSpec.describe Category, type: :model do
  before do
    @user = create(:user)
    @category = create(:category)
    @post = create(:post)
  end

  describe "バリデーション" do
    it "[name]空だったらNG" do
      @category.name = ""
      expect(@category.valid?).to eq(false)
    end

    it "nameの20文字制限" do
      @category.name = "12334447463862863874973497436"
      expect(@category.valid?).to eq(false)
    end
  end
end

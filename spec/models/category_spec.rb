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
  end
end

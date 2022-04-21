require 'rails_helper'

RSpec.describe User, type: :model do

  before do 
    @user = create(:user)
  end

  describe "バリデーション" do
    it "名前とemail, passwordの値が設定されていれば、OK" do
      expect(@user.valid?).to eq(true)
    end
  end

  it "nameが空だとNG" do
    @user.name = ""
    expect(@user.valid?).to eq(false)
  end

  it "emailが空だとNG" do
    @user.email = ""
    expect(@user.valid?).to eq(false)
  end

  it "emailが重複しているとNG" do
    @user.save
    @user2 = build(:user)
    @user2.email = @user.email
    expect(@user2.valid?).to eq(false)
  end

  it "passwordが空だとNG" do
    @user.password = ""
    expect(@user.valid?).to eq(false)
  end

  it"passwordが４文字以下だったらNG" do
    @user.password = "123"
    expect(@user.valid?).to eq(false)
  end

  it"passwordが10文字以上だったらNG" do
    @user.password = "1234567891011"
    expect(@user.valid?).to eq(false)
  end
end

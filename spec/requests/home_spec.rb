require 'rails_helper'

RSpec.describe "Homes", type: :request do
  let(:user) { create(:user) }

  describe "GET /top" do
    it "ステータスコードが200になること" do
      get root_path
      expect(response).to have_http_status(:success)
    end

    it "ログイン済の場合、リダイレクトされる" do
      login
      get root_path
      expect(response).to redirect_to(user_path(user))
    end
  end
end

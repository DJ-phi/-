require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe "GET /top" do
    it "ステータスコードが200になること" do
      get root_path
      expect(response).to have_http_status(:success)
    end

    # TODO: 終わってない
    it "ログイン済の場合、リダイレクトされる" do
      get root_path
      expect(response).to redirect_to(user_path(current_user))
    end
  end
end

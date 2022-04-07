require 'rails_helper'

RSpec.describe "Homes", type: :request do

  before do
    get "/home/top"
  end

  describe "GET /top" do
    it "ステータスコードが200になること" do
      expect(response).to have_http_status(:success)
    end
  end
end

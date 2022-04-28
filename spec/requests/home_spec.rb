require 'rails_helper'

RSpec.describe "Homes", type: :request do

  before do
    get root_path
  end

  describe "GET /top" do
    it "ステータスコードが200になること" do
      expect(response).to have_http_status(:success)
    end
  end
end

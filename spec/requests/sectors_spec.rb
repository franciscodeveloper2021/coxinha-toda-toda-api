require 'rails_helper'

RSpec.describe "Sectors", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/sectors/index"
      expect(response).to have_http_status(:success)
    end
  end

end

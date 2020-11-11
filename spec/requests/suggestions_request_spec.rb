require 'rails_helper'

RSpec.describe "Suggestions", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/suggestions/index"
      expect(response).to have_http_status(:success)
    end
  end

end

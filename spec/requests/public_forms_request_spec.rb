require 'rails_helper'

RSpec.describe "PublicForms", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/public_forms/index"
      expect(response).to have_http_status(:success)
    end
  end

end

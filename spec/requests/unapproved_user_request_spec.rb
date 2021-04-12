require 'rails_helper'

RSpec.describe "UnapprovedUsers", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/unapproved_user/index"
      expect(response).to have_http_status(:success)
    end
  end

end

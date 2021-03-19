require 'rails_helper'

RSpec.describe "Personalities", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/personalities/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /myersBriggs" do
    it "returns http success" do
      get "/personalities/myersBriggs"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /conflictManagement" do
    it "returns http success" do
      get "/personalities/conflictManagement"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /trueColors" do
    it "returns http success" do
      get "/personalities/trueColors"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /enneagram" do
    it "returns http success" do
      get "/personalities/enneagram"
      expect(response).to have_http_status(:success)
    end
  end

end

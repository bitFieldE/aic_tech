require 'rails_helper'

RSpec.describe "Tops", type: :request do
  describe "GET #index" do
    it "success request" do
      get root_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #login" do
    it "success request" do
      get login_url
      expect(response).to have_http_status(200)
    end
  end
end

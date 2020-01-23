require 'rails_helper'

RSpec.describe "Accounts", type: :request do
  describe "GET /show" do
    let(:user){create(:tom)}

    before do
      allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(user_id: user.id)
    end

    it "success request" do
      get account_path
      expect(response).to have_http_status(200)
    end

    it 'display login user profile' do
      get account_path
      expect(response.body).to include('Tom')
    end
  end

  describe 'GET #edit' do
    let(:user) { create(:tom) }

    before do
      allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(user_id: user.id)
    end

    it 'success request' do
      get edit_account_path
      expect(response).to have_http_status(200)
    end

    it 'display user attributes' do
      get edit_account_path
      expect(response.body).to include user.name
      expect(response.body).to include user.email
      expect(response.body).to include user.area
      expect(response.body).to include user.occupation
    end
  end
end

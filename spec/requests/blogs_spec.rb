require 'rails_helper'

RSpec.describe "Blogs", type: :request do
  let(:user) { FactoryBot.create :user }

  before do
    allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(user_id: user.id)
    create(:blog, author: user)
  end

  describe "GET #index" do
    it 'success response' do
      get blogs_path
      expect(response).to have_http_status(200)
    end
  end
end

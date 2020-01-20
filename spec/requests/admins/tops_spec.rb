require 'rails_helper'

RSpec.describe "Admins::Tops", type: :request do
  describe "GET index" do
    let(:user) { create(:user) }

    before do
      allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(user_id: user.id)
    end

    it "success request" do
      get admins_root_path
      expect(response).to have_http_status(200)
    end
  end
end

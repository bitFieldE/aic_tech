require 'rails_helper'

RSpec.describe "Relationships", type: :request do
  describe "GET #index" do
    let(:user){create(:tom)}
    before do
      allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(user_id: user.id)
    end
    it "works! (now write some real specs)" do
      get relationships_index_path
      expect(response).to have_http_status(200)
    end
  end
end

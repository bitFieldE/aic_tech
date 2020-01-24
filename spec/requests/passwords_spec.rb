require 'rails_helper'

RSpec.describe "Passwords", type: :request do
  describe 'GET /passwords' do
    let(:user){create(:tom)}
    before do
      allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(user_id: user.id)
    end

    it 'success request' do
      get password_path
      expect(response).to have_http_status(302)
    end

    it 'display user profile' do
      get password_path
      expect(response).to redirect_to :account
    end
  end

  describe "GET# edit" do
    let(:user){create(:tom)}
    before do
      allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(user_id: user.id)
    end

    it 'success request' do
      get edit_password_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'PUT #update' do
    let(:user) { create(:tom) }

    before do
      allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(user_id: user.id)
    end

    context 'valid parameters' do
      it 'success request' do
        put password_path,
          params: {
            account: {
              current_password: 'tom', password: 'john', password_confirmation: 'john'
            }
          }
        expect(response).to have_http_status(302)
      end

      it 'redirect to account' do
        put password_path,
          params: {
            account: {
              current_password: 'tom', password: 'john', password_confirmation: 'john'
            }
          }
        expect(response).to redirect_to :account
      end
    end

    context 'invalid parameters' do
      it 'success request' do
        put password_path,
          params: {
            account: {
              current_password: 'tom', password: 'john', password_confirmation: 'john'
            }
          }
        expect(response).to have_http_status(302)
      end


      it 'display errors' do
        put account_path, params: { account: FactoryBot.attributes_for(:john, :invalid) }
        expect(response.body).to include ''
        expect(response.body).to include ''
        expect(response.body).to include ''
      end
    end
  end
end

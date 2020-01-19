require 'rails_helper'

RSpec.describe "Admins::Users", type: :request do
  describe "GET #index" do
    let(:user) { FactoryBot.create :user }

    before do
      allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(user_id: user.id)
      FactoryBot.create :john
      FactoryBot.create :mary
    end

    it 'success request' do
      get admins_users_path
      expect(response).to have_http_status(200)
    end

    it 'diplay users' do
      get admins_users_url
      expect(response.body).to include "Mary"
      expect(response.body).to include "John"
    end
  end

  describe "GET #show" do
    let(:user) { FactoryBot.create :user }

    before do
      allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(user_id: user.id)
    end

    context 'exist user' do
      it 'success request' do
        get admins_user_url user.id
        expect(response).to have_http_status(200)
      end

      it 'display user name on the screen' do
        get user_url user.id
        expect(response.body).to include 'TestUserName60'
      end
    end

    context 'do not exist user' do
      subject { -> { get user_url 11 } }

      it { is_expected.to raise_error ActiveRecord::RecordNotFound }
    end
  end

 describe 'GET #edit' do
   let(:user) { FactoryBot.create :user }

   before do
     allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(user_id: user.id)
   end

   it 'success request' do
     get edit_admins_user_url user
     expect(response).to have_http_status(200)
   end

   it 'display user attributes' do
     get edit_admins_user_url user
     expect(response.body).to include user.name
     expect(response.body).to include user.email
     expect(response.body).to include user.area
     expect(response.body).to include user.occupation
   end
 end

  describe 'PUT #update' do
    let(:user) { FactoryBot.create :user }

    before do
      allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(user_id: user.id)
    end

    context 'valid parameters' do
      it 'success request' do
        put admins_user_url user, params: { user: FactoryBot.attributes_for(:john) }
        expect(response).to have_http_status(302)
      end

      it 'update user name' do
        expect do
          put admins_user_url user, params: { user: FactoryBot.attributes_for(:john) }
        end.to change { User.find(user.id).name }.from('TestUserName65').to('John')
      end

      it 'redirect to account' do
        put admins_user_url user, params: { user: FactoryBot.attributes_for(:john) }
        expect(response).to redirect_to "/admins/users/#{user.id}"
      end
    end

    context 'invalid parameters' do
      it 'success request' do
        put admins_user_url user, params: { user: FactoryBot.attributes_for(:user, :invalid) }
        expect(response).to have_http_status(200)
      end

      it 'will not change user name' do
        expect do
          put admins_user_url user, params: { user: FactoryBot.attributes_for(:user, :invalid) }
        end.to_not change(User.find(user.id), :name)
      end

      it 'display errors' do
        put admins_user_url user, params: { user: FactoryBot.attributes_for(:user, :invalid) }
        expect(response.body).to include 'ユーザー名を入力してください'
        expect(response.body).to include 'ユーザー名は半角英数字で入力してください'
        expect(response.body).to include 'ユーザー名は2文字以上で入力してください'
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:user) { FactoryBot.create :user }

    before do
      allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(user_id: user.id)
    end

    it 'success request' do
      delete admins_user_url user
      expect(response).to have_http_status(302)
    end

    it 'delete user' do
      expect do
        delete admins_user_url user
      end.to change(User, :count).by(-1)
    end

    it 'redierect to user list' do
      delete admins_user_url user
      expect(response).to redirect_to(admins_users_url)
    end
  end
end

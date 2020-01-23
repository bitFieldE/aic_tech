require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET #index" do
    let(:user) { create(:tom) }

    before do
      allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(user_id: user.id)
      FactoryBot.create :john
      FactoryBot.create :mary
    end

    it 'success request' do
      get users_path
      expect(response).to have_http_status(200)
    end

    it 'diplay users(not displayed male user from logined male user)' do
      get users_url
      expect(response.body).to include "Mary"
    end
  end

  describe "GET #show" do
    let(:user) { create(:tom) }

    before do
      allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(user_id: user.id)
    end

    context 'exist user' do
      it 'success request' do
        get user_url user.id
        expect(response).to have_http_status(200)
      end

      it 'display user name on the screen' do
        get user_url user.id
        expect(response.body).to include 'Tom'
      end
    end

    context 'do not exist user' do
      subject { -> { get user_url 11 } }

      it { is_expected.to raise_error ActiveRecord::RecordNotFound }
    end
  end

  describe 'GET #new' do
    it 'success request' do
      get new_user_url
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    context 'valid parameters' do
      it 'success reuest' do
        post users_url, params: { user: FactoryBot.attributes_for(:john) }
        expect(response).to have_http_status(302)
      end

      it 'resister user' do
        expect do
          post users_url, params: { user: FactoryBot.attributes_for(:john) }
        end.to change(User, :count).by(1)
      end

      it 'redirect to show' do
        post users_url, params: { user: FactoryBot.attributes_for(:john) }
        expect(response).to redirect_to :account
      end
    end

    context 'invalid parameters' do
      it 'success request' do
        post users_url, params: { user: FactoryBot.attributes_for(:john, :invalid) }
        expect(response).to have_http_status(200)
      end

      it 'will not resister user' do
        expect do
          post users_url, params: { user: FactoryBot.attributes_for(:john, :invalid) }
        end.to_not change(User, :count)
      end

      it 'エラーが表示されること' do
        post users_url, params: { user: FactoryBot.attributes_for(:john, :invalid) }
        expect(response.body).to include 'ユーザー名を入力してください'
        expect(response.body).to include 'ユーザー名は半角英数字で入力してください'
        expect(response.body).to include 'ユーザー名は2文字以上で入力してください'
      end
    end
  end
end

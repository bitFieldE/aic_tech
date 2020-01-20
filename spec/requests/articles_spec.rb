require 'rails_helper'

RSpec.describe "Articles", type: :request do
  let(:user) { create(:user) }
  let(:article) { create(:article) }

  before do
    FactoryBot.create :article
    allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(user_id: user.id)
  end

  describe "GET #index" do
    it "success request" do
      get articles_path
      expect(response).to have_http_status(200)
    end

    it 'diplay articles' do
      get articles_path
      expect(response.body).to include 'TestTitle'
    end
  end

  describe 'GET #show' do
    context 'exist article' do
        it 'success request' do
        get article_url article.id
        expect(response).to have_http_status(200)
      end

      it 'display title' do
        get article_url article.id
        expect(response.body).to include 'TestTitle'
      end
    end

    context 'do not exist article' do
      subject { -> { get article_url 11 } }

      it { is_expected.to raise_error ActiveRecord::RecordNotFound }
    end
  end
end

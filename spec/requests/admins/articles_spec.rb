require 'rails_helper'

RSpec.describe "Admins::Articles", type: :request do
  let(:user) { create(:user) }

  before do
    allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(user_id: user.id)
    create(:article)
  end

  describe "GET #index" do
    it "success request" do
      get admins_articles_path
      expect(response).to have_http_status(200)
    end

    it 'display articles' do
      get admins_articles_path
      expect(response.body).to include 'TestTitle'
    end
  end

  describe 'GET #show' do
    context 'exist article' do
      let(:article) { create(:article) }

      it 'success request' do
        get admins_article_url article.id
        expect(response).to have_http_status(200)
      end

      it 'display title' do
        get admins_article_url article.id
        expect(response.body).to include 'TestTitle'
      end
    end

    context 'do not exist article' do
      subject { -> { get admins_article_url 99 } }

      it { is_expected.to raise_error ActiveRecord::RecordNotFound }
    end
  end

  describe 'GET #new' do
    it 'success request' do
      get new_admins_article_url
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    let(:article) { create(:article) }

    context 'valid parameters' do
      it 'success request' do
        post admins_articles_url, params: { article: FactoryBot.attributes_for(:article) }
        expect(response).to have_http_status(302)
      end

      it 'resister article' do
        expect do
          post admins_articles_url, params: { article: FactoryBot.attributes_for(:article) }
        end.to change(Article, :count).by(1)
      end

      it 'redirect to last article page' do
        post admins_articles_url, params: { article: FactoryBot.attributes_for(:article) }
        expect(response).to redirect_to "/admins/articles/#{Article.last.id}"
      end
    end

    context 'invalid parameters' do
      it 'success request' do
        post admins_articles_url, params: { article: FactoryBot.attributes_for(:article, :invalid) }
        expect(response).to have_http_status(200)
      end

      it 'will not resister article' do
        expect do
          post admins_articles_url, params: { article: FactoryBot.attributes_for(:article, :invalid) }
        end.to_not change(Article, :count)
      end

      it 'display article' do
        post admins_articles_url, params: { article: FactoryBot.attributes_for(:article, :invalid) }
        expect(response.body).to include 'タイトルを入力してください'
      end
    end
  end

  describe 'PUT #update' do
    let(:article) { create(:article) }

    context 'valid parameters' do
      it 'success request' do
        put admins_article_url article, params: { article: FactoryBot.attributes_for(:article_b) }
        expect(response).to have_http_status(302)
      end

      it 'update article' do
        expect do
          put admins_article_url article, params: { article: FactoryBot.attributes_for(:article_b) }
        end.to change { Article.find(article.id).title }.from('TestTitle27').to('TestTitle B')
      end

      it 'redirect_to article page' do
        put admins_article_url article, params: { article: FactoryBot.attributes_for(:article_b) }
        expect(response).to redirect_to "/admins/articles/#{article.id}"
      end
    end

    context 'invalid parameters' do
      it 'success request' do
        put admins_article_url article, params: { article: FactoryBot.attributes_for(:article, :invalid) }
        expect(response).to have_http_status(200)
      end

      it 'will not change title' do
        expect do
          put admins_article_url article, params: { article: FactoryBot.attributes_for(:article, :invalid) }
        end.to_not change(Article.find(article.id), :title)
      end

      it 'display error' do
        put admins_article_url article, params: { article: FactoryBot.attributes_for(:article, :invalid) }
        expect(response.body).to include 'タイトルを入力してください'
      end
    end
  end
end

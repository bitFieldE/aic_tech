require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  let(:valid_attributes) {
    {
      title: "TestTitle",
      body: "TestText",
      released_at: 8.days.ago.advance(days: 3),
      expired_at: 2.days.ago.advance(days: 3),
      user_list_only: 1
    }
  }
  before do
    @article = create(:article, valid_attributes)
  end

  describe 'GET#index' do
    it 'returns success response' do
      expect(:get => "/articles").to route_to("articles#index")
    end
  end

  describe 'GET#show' do
    it 'returns success response' do
      expect(:get => "/articles/#{@article.id}").to route_to("articles#show", :id => "#{@article.id}")
    end
  end

  describe 'GET#new' do
    it 'returns success response' do
      expect(:get => "/articles/new").to route_to("articles#new")
    end
  end

  describe 'GET#edit' do
    it 'returns success response' do
      expect(:get => "/articles/#{@article.id}/edit").to route_to("articles#edit", :id => "#{@article.id}")
    end
  end

  describe 'POST#create' do
    it 'returns success response' do
      expect(:post => "/articles").to route_to("articles#create")
    end
  end

  describe 'PUT#update' do
    it 'returns success response' do
      expect(:put => "/articles/#{@article.id}").to route_to("articles#update", :id => "#{@article.id}")
    end
  end

  describe 'DELETE#destroy' do
    it 'returns success response' do
      expect(:delete => "/articles/#{@article.id}").to route_to("articles#destroy", :id => "#{@article.id}")
    end
  end
end

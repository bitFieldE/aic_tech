require 'rails_helper'

RSpec.describe BlogsController, type: :controller do
  before do
    @user =  User.create(
      name: "TestName",
      email: "TestName@example.com",
      birthday: "1980-01-01",
      gender: 1,
      area: User.areas.keys[5],
      occupation: User.occupations.keys[5],
      introduction: "TestText",
      voice: "TestChat",
      administrator: 0,
      password: "test",
      password_confirmation: "test"
    )
    @blog = Blog.create(
      author: @user,
      title: "Test title",
      body: "Test post",
      posted_at: Time.current,
      status: "user_list_only"
    )
  end

  describe 'GET#index' do
    it 'returns success response' do
      expect(:get => "/blogs").to route_to("blogs#index")
    end
  end

  describe 'GET#show' do
    it 'returns success response' do
      expect(:get => "/blogs/#{@blog.id}").to route_to("blogs#show", :id => "#{@blog.id}")
    end
  end

  describe 'GET#new' do
    it 'returns success response' do
      expect(:get => "/blogs/#{@blog.id}").to route_to("blogs#show", :id => "#{@blog.id}")
    end
  end

  describe 'GET#edit' do
    it 'returns success response' do
      expect(:get => "/blogs/#{@blog.id}/edit").to route_to("blogs#edit", :id => "#{@blog.id}")
    end
  end

  describe 'POST#create' do
    it 'returns success response' do
      expect(:post => "/blogs").to route_to("blogs#create")
    end
  end

  describe 'PUT#update' do
    it 'returns success response' do
      expect(:put => "/blogs/#{@blog.id}").to route_to("blogs#update", :id => "#{@blog.id}")
    end
  end

  describe 'GET#edit' do
    it 'returns success response' do
      expect(:delete => "/blogs/#{@blog.id}").to route_to("blogs#destroy", :id => "#{@blog.id}")
    end
  end
end

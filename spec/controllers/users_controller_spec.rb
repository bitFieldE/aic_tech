require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  # describe
  let(:valid_attributes) {
    {
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
    }
  }
  before do
    @user =  create(:user, valid_attributes)
  end


  describe 'GET#index' do
    it 'returns success response' do
      expect(:get => "/users").to route_to("users#index")
    end

    it 'should index field' do
      get :index
      expect(response.status).to eq(302)
    end
  end

  describe 'GET#show' do
    it 'returns success response' do
      expect(:get => "/users/#{@user.id}").to route_to("users#show", :id => "#{@user.id}")
    end

    it 'should show field' do
      get :show, params: { id: @user.id }
      expect(response.status).to eq(200)
    end
  end

  describe 'GET#new' do
    it 'returns success response' do
      expect(:get => "/users/new").to route_to("users#new")
    end
  end

  describe 'GET#edit' do
    it 'returns success response' do
      expect(:get => "/users/#{@user.id}/edit").to route_to("users#edit", :id => "#{@user.id}")
    end

    it 'should show field' do
      get :edit, params: { id: @user.id }
      expect(response.status).to eq(302)
    end
  end

  describe 'POST#create' do
    it 'returns success response' do
      expect(:post => "/users").to route_to("users#create")
    end

    it 'should show field' do
      post "/users"
      expect(response.status).to eq(201)
    end
  end

  describe 'PUT#update' do
    it 'returns success response' do
      expect(:put => "/users/#{@user.id}").to route_to("users#update", :id => "#{@user.id}")
    end
  end

  describe 'DELETE#destroy' do
    it 'returns success response' do
      expect(:delete => "/users/#{@user.id}").to route_to("users#destroy", :id => "#{@user.id}")
    end
  end
end
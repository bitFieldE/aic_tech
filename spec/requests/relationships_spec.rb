require 'rails_helper'

RSpec.describe 'Relationships', type: :request do
  describe 'GET #followers' do
    let(:user){create(:mary)}
    before do
      allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(user_id: user.id)
    end

    it 'success request' do
      get followers_relationships_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #followed' do
    let(:user){create(:mary)}
    before do
      allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(user_id: user.id)
    end

    it 'success request' do
      get followed_relationships_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #following' do
    let(:user){create(:mary)}
    before do
      allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(user_id: user.id)
    end

    it 'success request' do
      get matched_relationships_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    let(:female_user){create(:mary)}
    let(:male_user){create(:john)}

    before do
      allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(user_id: female_user.id)
    end

    context 'valid parameter' do
      it 'success request' do
        post relationships_url, params: {followed_id: male_user.id}, xhr: true
        expect(response).to have_http_status(200)
      end
    end

    context 'invalid parameter' do
      it 'raise error' do
        expect do
          post relationships_url, params: {followed_id: nil}, xhr: true
        end.to raise_error ActiveRecord::RecordNotFound
      end

      it 'duplicate error' do
        create(:relationship, follower_id: female_user.id, followed_id: male_user.id)
        expect do
          post relationships_url, params: {followed_id: male_user.id}, xhr: true
        end.to raise_error ActiveRecord::RecordNotUnique
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:female_user){create(:mary)}
    let(:male_user){create(:john)}

    before do
      allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(user_id: female_user.id)
      female_user.follow(male_user)
      @relationship = female_user.active_relationships.find_by(followed_id: male_user.id)
    end

    it 'success request' do
      delete relationship_url(@relationship), xhr: true
      expect(response).to have_http_status(200)
    end

    it 'invalid request' do
      @relationship = nil
      expect do
        delete relationship_url(@relationship), xhr: true
      end.to raise_error ActionController::UrlGenerationError
    end
  end
end

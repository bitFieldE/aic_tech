require 'rails_helper'

RSpec.describe TopController, type: :controller do
  describe 'GET #Top' do
    it 'render index' do
      get :index
      expect(response).to be_successful
    end

    it 'render login' do
      get :login
      expect(response).to be_successful
    end
  end
end

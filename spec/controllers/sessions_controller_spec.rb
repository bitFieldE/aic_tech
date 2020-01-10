require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe '' do
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
      @user =  User.create valid_attributes
    end

    it 'Post session' do
      redirect_to :session
      expect(response).to be_successful
    end
  end
end

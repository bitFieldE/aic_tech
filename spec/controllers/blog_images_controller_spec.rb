require 'rails_helper'

RSpec.describe BlogImagesController, type: :controller do
  before do
    @user = User.create(
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
  end

  describe 'DELETE#destroy' do
    it 'returns success response' do
      
    end
  end
end

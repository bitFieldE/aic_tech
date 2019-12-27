require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation User(Unit test)' do
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

    let(:invalid_attributes) {
      {
        name: nil,
        email: nil,
        birthday: nil,
        gender: nil,
        area: nil,
        occupation: nil,
        introduction: nil,
        voice: nil,
        administrator: nil,
        password: nil,
        password_confirmation: nil
      }
    }

    describe 'user registration' do
      before do
        @user = User.new valid_attributes
      end

      it {
        expect(@user.valid?).to be_truthy
        expect { @user.save }.to change { User.count }.by(1)
      }

      it 'blank of introduction' do
        @user.introduction = ""
        expect(@user).to be_valid
      end

      it 'blank of voice' do
        @user.voice = ""
        expect(@user).to be_valid
      end

      it 'name within 20 characters' do
        @user.name = "#{"A" * 20}"
        expect(@user).to be_valid
      end

      it 'introduction within 400 characters' do
        @user.introduction = "#{"A" * 400}"
        expect(@user).to be_valid
      end

      it 'blank of name' do
        @user.name = ""
        expect(@user).to be_invalid
      end

      it 'blank of email' do
        @user.email = ""
        expect(@user).to be_invalid
      end

      it 'name over 20 characters' do
        @user.name = "#{"A" * 99}"
        expect(@user).to be_invalid
      end

      it 'introduction over 400 characters' do
        @user.introduction = "#{"A" * 999}"
        expect(@user).to be_invalid
      end

      it 'voice over 25 characters' do
        @user.voice = "#{"A" * 99}"
        expect(@user).to be_invalid
      end

      it 'unexpected input of email' do
        @user.email = "abcdefghijk"
        expect(@user).to be_invalid
      end

      it 'blank of birthday' do
         @user.birthday = ""
         expect(@user).to be_invalid
      end

      it 'blank of area' do
        @user.area = ""
        expect(@user).to be_invalid
      end

      it 'blank of occupation' do
        @user.occupation = ""
        expect(@user).to be_invalid
      end
    end

    describe 'an invalid user registration' do
      before do
        @user = User.new invalid_attributes
      end

      it {
        expect(@user.valid?).to be_falsey
      }
    end
  end
end

require 'rails_helper'

RSpec.describe Blog, type: :model do

  describe 'validation of blog(unit test)' do
    before do
      @user = create(:user)
    end

    let(:valid_attributes) {
      {
        author: @user,
        title: "Test title",
        body: "Test post",
        posted_at: Time.current,
        status: "user_list_only"
      }
    }

    let(:invalid_attributes) {
      {
        author: @user,
        title: nil,
        body: nil,
        posted_at: nil,
        status: nil
      }
    }

    describe 'blog post' do
      before do
        @blog = build(:blog, valid_attributes)
      end

      it {
        expect(@blog.valid?).to be_truthy
        expect {@blog.save}.to change {Blog.count}.by(1)
      }

      it 'blank of title' do
        @blog.title = ""
        expect(@blog).to be_invalid
      end

      it 'nullify blank of body' do
        @blog.body = ""
        expect(@blog).to be_invalid
      end

      it 'nullify blank of status' do
        @blog.status = ""
        expect(@blog).to be_invalid
      end

      it 'nullify blank of posted_at' do
        @blog.posted_at = ""
        expect(@blog).to be_invalid
      end

      it 'validate title within 40 characters' do
        @blog.title = "#{"A" * 40}"
        expect(@blog).to be_valid
      end

      it 'nullify title over 40 characters' do
        @blog.title = "#{"A" * 99}"
        expect(@blog).to be_invalid
      end

      it 'validate body within 2000 characters' do
        @blog.body = "#{"A" * 2000}"
        expect(@blog).to be_valid
      end

      it 'nullify body over 2000 characters' do
        @blog.body = "#{"A" * 9999}"
        expect(@blog).to be_invalid
      end

      it 'validate expected input(public)' do
        @blog.status = "public"
        expect(@blog.status).to eq("public")
      end

      it 'validate expected input(user_list_only)' do
        @blog.status = "user_list_only"
        expect(@blog.status).to eq("user_list_only")
      end

      it 'validate expected input(draft)' do
        @blog.status = "draft"
        expect(@blog.status).to eq("draft")
      end

      it 'nullify unexpected input of status' do
        @blog.status = "12345"
        expect(@blog).to be_invalid
      end

      it 'nullify unexpected input of posted_at' do
        @blog.posted_at = "aaa"
        expect(@blog).to be_invalid
      end
    end

    describe 'blog post' do
      before do
        @blog =  build(:blog, invalid_attributes)
      end

      it {
        expect(@blog.valid?).to be_falsey
      }
    end
  end
end

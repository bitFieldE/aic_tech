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
        expect { @blog.save }.to change { Blog.count }.by(1)
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
#    before do
#      @blog = build(:blog)
#    end

#    context 'blog test(all-blank)' do
#      it 'nullify all blank' do
#        @blog.title = ""
#        @blog.body = ""
#        @blog.status = ""
#        @blog.posted_at = ""
#        expect(@blog).to be_invalid
#      end

#    end

#    context 'blog test(all-filled)' do
#      it 'validate all filled' do
#        expect(@blog).to be_valid
#      end

#      it 'validate existence of user_id' do
#        expect(@blog.author.blank?).to eq(false)
#      end

#    end
#  end

#  describe "Blog test index/show/new/create/update/destroy" do
#    before do
#      @blog = create(:blog)
#      visit "/login"
#      fill_in 'email', with: @blog.author.email
#      fill_in 'password', with: @blog.author.password
#      click_button 'ログイン'
#    end

#    context "index" do
#      it 'go to page MyBlog after login' do
#        visit :blogs
#        expect(page).to have_css('h2',text:'マイブログ')
#    end

#    context 'show' do
#      it 'show blog' do
#        visit "/blogs/#{@blog.id}"
#        expect(page).to have_css('h2',text: @blog.author.name + "さんのブログ")
#      end
#    end

#    context 'new' do
#      it 'create blog' do
#        visit '/blogs/new'
#        expect(page).to have_css('h2',text:'ブログの投稿')
#      end


#      it '' do

#      end
#    end
#  end
end

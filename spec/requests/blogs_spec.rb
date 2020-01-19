require 'rails_helper'

RSpec.describe "Blogs", type: :request do
  let(:user) { FactoryBot.create :user }

  before do
    allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(user_id: user.id)
    create(:blog, author: user)
  end

  describe "GET #index" do
    it 'success response' do
      get blogs_path
      expect(response).to have_http_status(200)
    end

    it 'success response' do
      get blogs_path
      expect(response.body).to include Blog.last.title
      expect(response.body).to include Blog.last.body
    end
  end

  describe 'GET #show' do
    let(:blog) {create(:blog, author: user)}
    context 'exist blog' do
      it 'success request' do
        get blog_url blog.id
        expect(response).to have_http_status(200)
      end

      it 'display blog' do
        get blog_url blog.id
        expect(response.body).to include "#{blog.author.name}さんのブログ"
        expect(response.body).to include blog.title
        expect(response.body).to include blog.body
      end
    end

    context 'do not exist blog' do
      subject { -> { get blog_url 11 } }

      it { is_expected.to raise_error ActiveRecord::RecordNotFound }
    end
  end

  describe 'GET #new' do
    it 'success request' do
      get new_blog_url
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #edit' do
    let(:blog) { create(:blog, author: user) }

    it 'success request' do
      get edit_blog_url blog
      expect(response).to have_http_status(200)
    end

    it 'display title' do
      get edit_blog_url blog
      expect(response.body).to include blog.title
    end

    it 'display body' do
      get edit_blog_url blog
      expect(response.body).to include blog.body
    end
  end

  describe 'POST #create' do
    context 'valid paramsters' do
      it 'success request' do
        post blogs_url, params: { blog: FactoryBot.attributes_for(:blog) }
        expect(response).to have_http_status(302)
      end

      it 'resister blog' do
        expect do
          post blogs_url, params: { blog: FactoryBot.attributes_for(:blog) }
        end.to change(Blog, :count).by(1)
      end

      it 'redirect to blog' do
        post blogs_url, params: { blog: FactoryBot.attributes_for(:blog) }
        expect(response).to redirect_to Blog.last
      end
    end

    context 'invalid parameters' do
      it 'success request' do
        post blogs_url, params: { blog: FactoryBot.attributes_for(:blog, :invalid) }
        expect(response).to have_http_status(200)
      end

      it 'will not resister blog' do
        expect do
          post blogs_url, params: { blog: FactoryBot.attributes_for(:blog, :invalid) }
        end.to_not change(Blog, :count)
      end

      it 'diplay errors' do
        post blogs_url, params: { blog: FactoryBot.attributes_for(:blog, :invalid) }
        expect(response.body).to include 'タイトルを入力してください'
        expect(response.body).to include '本文を入力してください'
      end
    end
  end

  describe 'PUT #update' do
    let(:blog) {create(:blog, author: user)}

    context 'valid paramsters' do
      it 'success request' do
        put blog_url blog, params: { blog: FactoryBot.attributes_for(:blog_2) }
        expect(response).to have_http_status(302)
      end

      it 'resister blog' do
        expect do
          put blog_url blog, params: { blog: FactoryBot.attributes_for(:blog_2) }
        end.to change{ Blog.find(blog.id).title }.from('Blog test33').to('Blog2')
      end

      it 'redirect to blog' do
        put blog_url blog, params: { blog: FactoryBot.attributes_for(:blog_2) }
        expect(response).to redirect_to Blog.last
      end
    end

    context 'invalid parameters' do
      it 'success request' do
        put blog_url blog, params: { blog: FactoryBot.attributes_for(:blog_2, :invalid) }
        expect(response).to have_http_status(200)
      end

      it 'will not resister blog' do
        expect do
          put blog_url blog, params: { blog: FactoryBot.attributes_for(:blog_2, :invalid) }
        end.to_not change(Blog.find(blog.id), :title)
      end

      it 'diplay errors' do
        put blog_url blog, params: { blog: FactoryBot.attributes_for(:blog_2, :invalid) }
        expect(response.body).to include 'タイトルを入力してください'
        expect(response.body).to include '本文を入力してください'
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:blog) {create(:blog, author: user)}

    it 'success request' do
      delete blog_url blog
      expect(response).to have_http_status(302)
    end

    it 'delete blog' do
      expect do
        delete blog_url blog
      end.to change(Blog, :count).by(-1)
    end

    it 'redirect to blogs list' do
      delete blog_url blog
      expect(response).to redirect_to blogs_url
    end
  end
end

require 'rails_helper'

RSpec.feature "Blogs", type: :feature do
  before do
    @user = create(:user)
    visit '/login'
    fill_in 'email', with: @user.email
    fill_in 'password', with: @user.password
    click_button 'ログイン'
    @blog = create(:blog, author: @user)
  end

  scenario 'should show template index' do
    visit blogs_path
    expect(page).to have_content 'マイブログ'
    expect(page).to have_content @blog.posted_at.strftime("%Y %m/%d %H:%M")
    expect(page).to have_content @blog.title
    expect(page).to have_content @blog.body
  end

  scenario 'should show template show' do
    visit "/blogs/#{@blog.id}"
    expect(page).to have_content @blog.title
    expect(page).to have_content @blog.body
    expect(page).to have_content @blog.posted_at.strftime("%Y %m/%d %H:%M")
    expect(page).to have_content Blog.status_text(@blog.status)
  end

  scenario 'should show template show' do
    visit "/blogs/#{@blog.id}"
    expect(page).to have_content @blog.title
    expect(page).to have_content @blog.body
    expect(page).to have_content @blog.posted_at.strftime("%Y %m/%d %H:%M")
    expect(page).to have_content Blog.status_text(@blog.status)
  end

  scenario 'should show template new' do
    visit "/blogs/new"
    expect(page).to have_field 'blog_title'
    expect(page).to have_field 'blog_body'
    expect(page).to have_field 'blog_status'
  end

  scenario 'should show template edit' do
    visit "/blogs/#{@blog.id}/edit"
    expect(page).to have_content '編集'
    expect(page).to have_field 'blog_title', with: @blog.title
    expect(page).to have_field 'blog_body', with: @blog.body
    expect(page).to have_field 'blog_status', with: @blog.status
  end
end

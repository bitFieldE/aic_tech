require 'rails_helper'

RSpec.feature "Blogs", type: :feature do
  before do
    user = create(:user)
    visit '/login'
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    click_button 'ログイン'
    @blog = create(:blog, author: user)
  end

  scenario 'index' do
    visit blogs_path
    expect(page).to have_content 'マイブログ'
    expect(page).to have_content @blog.posted_at.strftime("%Y %m/%d %H:%M")
    expect(page).to have_content @blog.title
    expect(page).to have_content @blog.body
  end

  scenario 'show' do
    visit "/blogs/#{@blog.id}"
    expect(page).to have_content @blog.title
    expect(page).to have_content @blog.body
    expect(page).to have_content @blog.posted_at.strftime("%Y %m/%d %H:%M")
    expect(page).to have_content Blog.status_text(@blog.status)
  end

  scenario 'new' do
    visit "/blogs/new"
    expect(page).to have_field 'blog_title'
    expect(page).to have_field 'blog_body'
    expect(page).to have_field 'blog_status'
  end

  scenario 'edit' do
    visit "/blogs/#{@blog.id}/edit"
    expect(page).to have_content '編集'
    expect(page).to have_field 'blog_title', with: @blog.title
    expect(page).to have_field 'blog_body', with: @blog.body
    expect(page).to have_field 'blog_status', with: @blog.status
  end

  scenario 'update' do
    visit "/blogs/#{@blog.id}/edit"
    click_button '更新'
    expect(page).to have_content 'ブログを更新しました'
  end

  scenario 'destroy' do
    visit "/blogs/#{@blog.id}"
    click_link '削除'
    expect(page).to have_content '投稿を削除しました'
  end
end

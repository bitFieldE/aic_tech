require 'rails_helper'

RSpec.feature "Blogs", type: :feature do
  before do
    @user = create(:user)
    visit '/login'
    fill_in 'email', with: @user.email
    fill_in 'password', with: @user.password
    click_button 'ログイン'
    @blog = create(
      :blog,
      author: @user,
      title: "Test title",
      body: "Test post",
      posted_at: Time.current,
      status: "user_list_only"
    )
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
end

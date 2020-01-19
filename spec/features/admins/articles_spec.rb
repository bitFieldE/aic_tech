require 'rails_helper'

RSpec.feature "Admins::Articles", type: :feature do
  before do
    @user = create(:user)
    visit '/login'
    fill_in 'email', with: @user.email
    fill_in 'password', with: @user.password
    click_button 'ログイン'
    @article = create(:article)
  end

  scenario 'index' do
    visit admins_articles_url
    expect(page).to have_content '管理者専用 ニュースリスト'
  end

  scenario 'show' do
    visit "/admins/articles/#{@article.id}"
    expect(page).to have_content 'ニュース詳細 管理者用'
    expect(page).to have_content @article.title
    expect(page).to have_content @article.body
    expect(page).to have_content @article.user_list_only? ? "★" : "-"
  end

  scenario 'edit' do
    visit "/admins/articles/#{@article.id}/edit"
    expect(page).to have_content 'ニュースの編集 管理者用'
  end

  scenario 'update' do
    visit "/admins/articles/#{@article.id}/edit"
    click_button '更新する'
    expect(page).to have_content 'ニュースを編集しました'
  end

  scenario 'destroy' do
    visit admins_articles_url
    click_link '削除'
    expect(page).to have_content 'ニュースを削除しました'
  end
end

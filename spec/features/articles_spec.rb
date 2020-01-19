require 'rails_helper'

RSpec.feature "Articles", type: :feature do
  before do
    @article = create(:article)
  end

  scenario 'index' do
    visit "/articles"
    expect(page).to have_content 'ニュースリスト'
    expect(page).to have_content '記事タイトル'
    expect(page).to have_content '作成日時'
  end

  scenario 'show' do
    visit "articles/#{@article.id}"
    expect(page).to have_content @article.title
    expect(page).to have_content @article.body
    expect(page).to have_content @article.user_list_only? ? "★" : "-"
  end
end

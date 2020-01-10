require 'rails_helper'

RSpec.feature "Articles", type: :feature do

  before do
    @article = create(
      :article,
      title: "TestTitle",
      body: "TestText",
      released_at: 8.days.ago.advance(days: 3),
      expired_at: 2.days.ago.advance(days: 3),
      user_list_only: 1
    )
  end

  scenario 'article index' do
    visit "/articles"
    expect(page).to have_content 'ニュースリスト'
    expect(page).to have_content '記事タイトル'
    expect(page).to have_content '作成日時'
  end

  scenario 'article show' do
    visit "articles/#{@article.id}"
    expect(page).to have_content @article.title
    expect(page).to have_content @article.body
  end
end

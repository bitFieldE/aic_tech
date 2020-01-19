require 'rails_helper'

RSpec.feature "Admins::Tops", type: :feature do
  before do
    user = create(:user)
    visit '/login'
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    click_button 'ログイン'
  end

  scenario 'admins top index page' do
    visit admins_top_index_url
    expect(page).to have_content '会員管理'
    expect(page).to have_content 'ニュース記事管理'
  end
end

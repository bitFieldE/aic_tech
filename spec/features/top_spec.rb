require 'rails_helper'

RSpec.feature "Tops", type: :feature do
  let(:user){create(:tom)}

  scenario 'login page' do
    visit '/login'
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    click_button 'ログイン'
    expect(page).to have_content 'ログインしました'
    expect(page).to have_css('.name-display', text: user.name)
  end

  scenario 'top page' do
    visit root_path
    expect(page).to have_content '最新ニュース'
    expect(page).to have_css('.single-item')
  end
end

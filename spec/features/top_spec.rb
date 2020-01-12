require 'rails_helper'

RSpec.feature "Tops", type: :feature do
  before do
    @user = create(:user)
  end

  scenario 'login page' do
    visit '/login'
    fill_in 'email', with: @user.email
    fill_in 'password', with: @user.password
    click_button 'ログイン'
    expect(page).to have_content 'ログインしました'
    expect(page).to have_css('.name-display', text: @user.name)
  end

  senario 'top ' do
    visit root_path
    expect(page).to have_content ''
  end
end

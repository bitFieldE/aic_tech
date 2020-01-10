require 'rails_helper'

RSpec.feature "Users", type: :feature do

  before do
    @user = create(:user)
    visit '/login'
    fill_in 'email', with: @user.email
    fill_in 'password', with: @user.password
    click_button 'ログイン'
  end

  scenario 'should show template index' do
    visit users_path
    expect(page).to have_content '会員一覧'
    expect(page).to have_content '年齢'
    expect(page).to have_content '出身地'
    expect(page).to have_content '職業'
    expect(page).to have_content 'つぶやき'
  end

  scenario 'should show template show' do
    visit "/users/#{@user.id}"
    expect(page).to have_content @user.name
    expect(page).to have_content @user.area
    expect(page).to have_content @user.voice
    expect(page).to have_content @user.introduction
  end

  scenario 'new' do
  #  visit {:controller=>"sessions", :action=>"destroy"}
  #  visit '/users/new'
  #  expect(page).to have_content '新規ユーザー登録'
  end

  scenario 'edit' do
    visit "/users/#{@user.id}"
  end
end

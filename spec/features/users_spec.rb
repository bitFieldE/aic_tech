require 'rails_helper'

RSpec.feature "Users", type: :feature do

  before do
    @user = create(:user)
    visit '/login'
    fill_in 'email', with: @user.email
    fill_in 'password', with: @user.password
    click_button 'ログイン'
  end

  scenario 'index' do
    visit users_path
    expect(page).to have_content '会員一覧'
    expect(page).to have_content '年齢'
    expect(page).to have_content '出身地'
    expect(page).to have_content '職業'
    expect(page).to have_content 'つぶやき'
  end

  scenario 'show' do
    visit "/users/#{@user.id}"
    expect(page).to have_content @user.name
    expect(page).to have_content @user.area
    expect(page).to have_content @user.occupation
    expect(page).to have_content @user.voice
    expect(page).to have_content @user.introduction
  end

  scenario 'new' do
    visit root_path
    find('.droptool').click
    click_link 'Logout'
    visit '/users/new'
    expect(page).to have_content '新規ユーザー登録'
    expect(page).to have_field 'new_profile_picture'
    expect(page).to have_field 'user_name'
    expect(page).to have_field 'user_email'
    expect(page).to have_field 'user_password'
    expect(page).to have_field 'user_birthday_1i'
    expect(page).to have_field 'user_birthday_2i'
    expect(page).to have_field 'user_birthday_3i'
    expect(page).to have_checked_field('男性', visible:false)
    expect(page).to have_field 'user_area'
    expect(page).to have_field 'user_occupation'
    expect(page).to have_field 'user_voice'
  end

  scenario 'edit' do
    visit "/users/#{@user.id}/edit"
    expect(page).to have_field 'new_profile_picture'
    expect(page).to have_field 'user_name', with: @user.name
    expect(page).to have_field 'user_email', with: @user.email
    expect(page).to have_checked_field '男性'
    expect(page).to have_select('user_birthday_1i', selected: '1980')
    expect(page).to have_select('user_birthday_2i', selected: '1')
    expect(page).to have_select('user_birthday_3i', selected: '1')
    expect(page).to have_field 'user_introduction', with: @user.introduction
    expect(page).to have_field 'user_voice', with: @user.voice
    expect(page).to have_field 'user_area', with: @user.area
    expect(page).to have_field 'user_occupation', with: @user.occupation
  end

  scenario 'update' do
    visit "/users/#{@user.id}/edit"
    click_button '更新する'
    expect(page).to have_content '会員を更新しました'
  end
end
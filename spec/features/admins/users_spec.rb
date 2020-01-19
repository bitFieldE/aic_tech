require 'rails_helper'

RSpec.feature "Admins::Users", type: :feature do
  before do
    @user = create(:user)
    visit '/login'
    fill_in 'email', with: @user.email
    fill_in 'password', with: @user.password
    click_button 'ログイン'
  end

  scenario 'index' do
    visit admins_users_url
    expect(page).to have_content '管理者専用 会員ページ'
    expect(page).to have_content '年齢'
    expect(page).to have_content '出身地'
    expect(page).to have_content '職業'
    expect(page).to have_content 'つぶやき'
    expect(page).to have_content '編集'
    expect(page).to have_content '削除'
    expect(page).to have_content @user.name
    expect(page).to have_content @user.area
    expect(page).to have_content @user.occupation
    expect(page).to have_content @user.voice
  end

  scenario 'show' do
    visit "/admins/users/#{@user.id}"
    expect(page).to have_content '管理者専用 プロフィールページ'
    expect(page).to have_content @user.name
    expect(page).to have_content @user.area
    expect(page).to have_content @user.occupation
    expect(page).to have_content @user.voice
    expect(page).to have_content @user.introduction
  end

  scenario 'edit' do
    visit "/admins/users/#{@user.id}/edit"
    expect(page).to have_content '編集 管理者用'
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
    visit "/admins/users/#{@user.id}/edit"
    click_button '更新する'
    expect(page).to have_content('会員を更新しました')
  end

  scenario 'destroy' do
    visit admins_users_url
    click_link '削除', match: :first
    expect(page).to have_content('プロフィールを削除しました')
  end
end

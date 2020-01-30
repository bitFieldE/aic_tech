require 'rails_helper'

RSpec.feature "Relationships", type: :feature do
  let(:male_user){create(:john)}
  let(:female_user){create(:mary)}
  before do
    allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(user_id: female_user.id)
    create(:relationship, follower_id: female_user.id, followed_id: male_user.id)
    visit root_path
    find('.droptool').click
    click_link 'Matching'
  end

  scenario 'GET#followers' do
    expect(page).to have_content 'いいかもした人'
  end

  scenario 'GET#followed' do
    click_link 'もらったいいかも'
    expect(page).to have_content 'いいかもしてくれた人'
  end

  scenario 'GET#matched' do
    click_link 'マッチング成立'
    expect(page).to have_content 'マッチング成立した人'
  end
end

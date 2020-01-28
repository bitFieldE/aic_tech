require 'rails_helper'

RSpec.feature "Relationships", type: :feature do
  let(:male_user){create(:john)}
  let(:female_user){create(:mary)}
  before do
    allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(user_id: female_user.id)
    create(:relationship, follower_id: female_user.id, followed_id: male_user.id)
  end

  describe '' do
    let(:female_user){create(:mary)}
  end
end

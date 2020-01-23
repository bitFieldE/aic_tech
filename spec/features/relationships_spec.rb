require 'rails_helper'

RSpec.feature "Relationships", type: :feature do
  before do
    @user_male = create(:john)
    @user_female = create(:mary)
  end
  
end

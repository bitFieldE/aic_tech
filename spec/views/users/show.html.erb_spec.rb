require 'rails_helper'

RSpec.describe "users/show", type: :view do
  pending "add some examples to (or delete) #{__FILE__}"

  before do
    visit "/login"
    fill_in 'email', with: @blog.author.email
    fill_in 'password', with: @blog.author.password
    click_button 'ログイン'
  end

end

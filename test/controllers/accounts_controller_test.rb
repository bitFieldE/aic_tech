require 'test_helper'

class AccountsControllerTest < ActionDispatch::IntegrationTest
  # rooting_test
  test "should get show" do
    get accounts_show_url
    assert_response :success
  end

  test "should get edit" do
    get accounts_edit_url
    assert_response :success
  end

end

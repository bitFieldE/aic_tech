require 'test_helper'

class TopControllerTest < ActionDispatch::IntegrationTest

  test "should get index" do
    get top_index_url
    assert_response :success
  end

  test "should get login" do
    get "/login"
    assert_response :success
  end

  test "should get about" do
    get "/about"
    assert_response :success
  end

  test "should get signin" do
    get "/signin"
    assert_response :success
  end
end

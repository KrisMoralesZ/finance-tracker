require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get my_stocks" do
    get users_my_portfolio_url
    assert_response :success
  end
end

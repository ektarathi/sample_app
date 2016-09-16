require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:stacy)
    @other_user = users(:milleytest)
  end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should redirect edit when not logged in" do
  	get edit_user_path(@user)
  	assert_not flash.empty?
  	assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
  	patch user_path(@user), user: { name: @user.name,
                                              email: @user.email }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect index when not logged in" do
    get users_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end
end

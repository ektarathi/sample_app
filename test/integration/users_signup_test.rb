require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

 test "invalid signup information" do
    get signup_path
    post users_path, user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" }
    assert_template 'users/new'
    assert_response :success
  end

  test "valid signup information" do
    get signup_path
    post users_path, user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert is_logged_in?
  end
end
